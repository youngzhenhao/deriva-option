// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {PriceFeedConsumer} from "./OptionPriceFeedConsumer.sol";

contract CallOptions is ReentrancyGuard {
    error Unauthorized_ETH();
    error TransferFailed_ETH();
    error OptionNotValid_ETH(uint256 _optionId);

    event CallOptionOpen_ETH(address indexed writer, uint256 id, uint256 expiration, uint256 value);
    event CallOptionBought_ETH(address indexed buyer, uint256 id);
    event CallOptionExercised_ETH(address indexed buyer, uint256 id);
    event OptionExpiresWorthless_ETH(address indexed buyer, uint256 Id);
    event FundsRetrieved_ETH(address indexed writer, uint256 id, uint256 value);

    PriceFeedConsumer internal priceFeed;
    IERC20 dai;
    uint256 public lastOptionId_ETH;

    mapping(address => address) public tokenToEthFeed;
    mapping(uint256 => Option) public optionIdToOption;
    mapping(address => uint256[]) public tradersPosition;

    enum OptionState {
        Closed,
        Open,
        Bought,
        Cancelled,
        Exercised
    }
    enum OptionType {
        Call,
        Put
    }

    struct Option {
        address writer;
        address buyer;
        uint256 strike;
        uint256 premiumDue;
        uint256 expiration;
        uint256 collateral;
        OptionState optionState;
        OptionType optionType;
    }

    modifier optionExists_ETHCall(uint256 id) {
        if (optionIdToOption[id].writer == address(0)) {
            revert OptionNotValid_ETH(id);
        }
        _;
    }

    modifier isValidOpenOption_ETHCall(uint256 id) {
        if (optionIdToOption[id].optionState != OptionState.Open || optionIdToOption[id].expiration > block.timestamp) {
            revert OptionNotValid_ETH(id);
        }
        _;
    }

    //CONSTRUCTOR
    constructor(address _daiAddr, address _priceFeedAddr) {
        dai = IERC20(_daiAddr);
        priceFeed = PriceFeedConsumer(_priceFeedAddr);
        tokenToEthFeed[_daiAddr] = _priceFeedAddr;
    }

    ///@dev Write a call option against ETH collateral
    function sellCall_ETHCall(uint256 _strike, uint256 _premiumDue, uint256 _secondsToExpiry)
        external
        payable
        returns (uint256)
    {
        //To simplify, we only make one strike available, strike is the current marketprice.
        if (msg.value != _strike) revert Unauthorized_ETH();

        ++lastOptionId_ETH;

        optionIdToOption[lastOptionId_ETH] = Option(
            msg.sender,
            address(0x1),
            _strike,
            _premiumDue,
            block.timestamp + _secondsToExpiry,
            //msg.value is the ETH collateral.
            msg.value,
            OptionState.Open,
            OptionType.Call
        );

        tradersPosition[msg.sender].push(lastOptionId_ETH);

        emit CallOptionOpen_ETH(msg.sender, lastOptionId_ETH, block.timestamp + _secondsToExpiry, msg.value);

        return lastOptionId_ETH;
    }

    ///@dev Buy an available call option.
    function buyCall_ETHCall(uint256 _optionId) external nonReentrant {
        Option memory option = optionIdToOption[_optionId];

        if (option.optionType != OptionType.Call || option.optionState != OptionState.Open) revert Unauthorized_ETH();

        //buyer pays writer w dai
        bool paid = dai.transferFrom(msg.sender, option.writer, option.premiumDue);
        if (!paid) revert TransferFailed_ETH();

        optionIdToOption[_optionId].buyer = msg.sender;
        optionIdToOption[_optionId].optionState = OptionState.Bought;
        tradersPosition[msg.sender].push(_optionId);

        emit CallOptionBought_ETH(msg.sender, _optionId);
    }

    ///@dev Buyer gets to exercise the option is spot price > strike after expiration.
    function exerciseCall_ETHCall(uint256 _optionId, uint256 _amount) external payable optionExists_ETHCall(_optionId) nonReentrant {
        Option memory option = optionIdToOption[_optionId];

        if (msg.sender != option.buyer) revert Unauthorized_ETH();
        if (option.optionState != OptionState.Bought) revert Unauthorized_ETH();
        if (option.expiration > block.timestamp) revert Unauthorized_ETH();

        //for dai/eth, chainlink returns x amt of eth for 1 dai
        uint256 marketPriceInEth = priceFeed.getPriceFeed(_amount);

        //strike is in eth
        require(marketPriceInEth > option.strike, "NOT GREATER THAN STRIKE");

        //convert price to DAI so can send dai amount to writer
        uint256 strikeInDai = _amount / option.strike;

        //buyer gets right to buy ETH at strike w DAI
        bool paid = dai.transferFrom(msg.sender, option.writer, strikeInDai);
        if (!paid) revert TransferFailed_ETH();

        //transfer to msg.sender the writer's ETH collateral
        //recall, for this example msg.value == strike == collateral
        (paid,) = payable(msg.sender).call{value: option.collateral}("");
        if (!paid) revert TransferFailed_ETH();

        optionIdToOption[_optionId].optionState = OptionState.Exercised;

        emit CallOptionExercised_ETH(msg.sender, _optionId);
    }

    ///@dev Cancel Option after expiration and if it's worthless
    ///In practice, a function like this would probably get run by the protocol
    function optionExpiresWorthless_ETHCall(uint256 _optionId, uint256 _amount) external optionExists_ETHCall(_optionId) {
        Option memory option = optionIdToOption[_optionId];

        if (option.optionState != OptionState.Bought) revert Unauthorized_ETH();

        //etiher writer or buyer can cancel option after expiration if it is worthless
        if (optionIdToOption[_optionId].buyer != msg.sender || optionIdToOption[_optionId].writer != msg.sender) {
            revert Unauthorized_ETH();
        }

        if (option.expiration > block.timestamp) revert Unauthorized_ETH();
        if (option.optionType != OptionType.Call) revert Unauthorized_ETH();

        uint256 marketPriceInEth = priceFeed.getPriceFeed(_amount);

        //For call, if market < strike, call options expire worthless
        if (marketPriceInEth >= option.strike) revert Unauthorized_ETH();

        optionIdToOption[_optionId].optionState = OptionState.Cancelled;

        emit OptionExpiresWorthless_ETH(msg.sender, _optionId);
    }

    ///@dev Writer of the call option may collect their ETH collateral after option has expired and if it's worthless.
    function retrieveExpiredFunds_ETHCall(uint256 _optionId) external nonReentrant {
        Option memory option = optionIdToOption[_optionId];

        if (option.optionState != OptionState.Cancelled) revert Unauthorized_ETH();
        if (msg.sender != option.writer) revert Unauthorized_ETH();

        (bool paid,) = payable(msg.sender).call{value: option.collateral}("");
        if (!paid) revert TransferFailed_ETH();

        emit FundsRetrieved_ETH(msg.sender, _optionId, option.collateral);
    }

    receive() external payable {}
}
