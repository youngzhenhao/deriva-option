// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ReentrancyGuard} from
    "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {FT} from "./FT.sol";
import {PriceFeedConsumer} from "./oracle/PriceFeedConsumer.sol";

// @title COVERED CALL OPTIONS
// @notice This Smart Contract allows for the buying/writing of Covered Calls with ETH as the underlying.
// As an Example, use Chainlink DAI/ETH Price Feed.
// Calls: Let you buy an asset at a set price on a specific date.
// Covered Call: The seller(writer) transfers ETH for collateral and writes a Covered Call. The buyer pays premium w DAI.
// Covered Call: At expiration, the buyer has right to ETH at strike price if market price is greater than strike price. Settles with DAI.
// All options have the following properties:
// Strike price - The price at which the underlying asset can either be bought or sold.
// Expiry - The date at which the option expires.
// Premium - The price of the options contract.
// Probable strategy for option writer:
// Covered Calls - You sell upside on an asset while you hold it for yield, which comes from premium (Netural/Bullish on asset).

contract CallOptions is ReentrancyGuard {
    error Unauthorized(address);
    error WrongValue(uint256);
    error WrongTypeOrState();
    error WrongState(OptionState);
    error WrongType(OptionType);
    error WrongTime(uint256);

    error TransferFailed();
    error OptionNotValid(uint256 _optionId);

    event CallOptionOpen(
        address indexed writer, uint256 id, uint256 expiration, uint256 value
    );
    event CallOptionBought(address indexed buyer, uint256 id);
    event CallOptionExercised(address indexed buyer, uint256 id);
    event OptionExpiresWorthless(address indexed buyer, uint256 Id);
    event FundsRetrieved(address indexed writer, uint256 id, uint256 value);

    PriceFeedConsumer internal priceFeed;
    FT dai;
    uint256 public optionId;

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

    modifier optionExists(uint256 id) {
        if (optionIdToOption[id].writer == address(0)) {
            revert OptionNotValid(id);
        }
        _;
    }

    modifier isValidOpenOption(uint256 id) {
        if (
            optionIdToOption[id].optionState != OptionState.Open
                || optionIdToOption[id].expiration > block.timestamp
        ) {
            revert OptionNotValid(id);
        }
        _;
    }

    //CONSTRUCTOR
    constructor(address _daiAddr, address _priceFeedAddr) {
        dai = FT(_daiAddr);
        priceFeed = PriceFeedConsumer(_priceFeedAddr);
    }

    ///@dev Write a call option against ETH collateral
    function sellCall(
        uint256 _strike,
        uint256 _premiumDue,
        uint256 _secondsToExpiry
    ) external payable returns (uint256) {
        //To simplify, we only make one strike available, strike is the current marketprice.
        if (msg.value != _strike) revert WrongValue(msg.value);

        ++optionId;

        optionIdToOption[optionId] = Option(
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

        tradersPosition[msg.sender].push(optionId);

        emit CallOptionOpen(
            msg.sender, optionId, block.timestamp + _secondsToExpiry, msg.value
        );

        return optionId;
    }

    ///@dev Buy an available call option.
    function buyCall(uint256 _optionId) external nonReentrant {
        Option memory option = optionIdToOption[_optionId];

        if (
            option.optionType != OptionType.Call
                || option.optionState != OptionState.Open
        ) revert WrongTypeOrState();

        //buyer pays writer w dai
        bool paid =
            dai.transferFrom(msg.sender, option.writer, option.premiumDue);
        if (!paid) revert TransferFailed();

        optionIdToOption[_optionId].buyer = msg.sender;
        optionIdToOption[_optionId].optionState = OptionState.Bought;
        tradersPosition[msg.sender].push(_optionId);

        emit CallOptionBought(msg.sender, _optionId);
    }

    ///@dev Buyer gets to exercise the option is spot price > strike after expiration.
    function exerciseCall(
        uint256 _optionId,
        uint256 _amount
    ) external payable optionExists(_optionId) nonReentrant {
        Option memory option = optionIdToOption[_optionId];

        if (msg.sender != option.buyer) revert Unauthorized(msg.sender);
        if (option.optionState != OptionState.Bought) revert WrongState(option.optionState);
        if (option.expiration > block.timestamp) revert WrongTime(block.timestamp);

        //for dai/eth, chainlink returns x amt of eth for 1 dai
        uint256 marketPriceInEth = priceFeed.getPriceFeed(_amount);

        //strike is in eth
        require(marketPriceInEth > option.strike, "NOT GREATER THAN STRIKE");

        //convert price to DAI so can send dai amount to writer
        uint256 strikeInDai = _amount / option.strike;

        //buyer gets right to buy ETH at strike w DAI
        bool paid = dai.transferFrom(msg.sender, option.writer, strikeInDai);
        if (!paid) revert TransferFailed();

        //transfer to msg.sender the writer's ETH collateral
        //recall, for this example msg.value == strike == collateral
        (paid,) = payable(msg.sender).call{value: option.collateral}("");
        if (!paid) revert TransferFailed();

        optionIdToOption[_optionId].optionState = OptionState.Exercised;

        emit CallOptionExercised(msg.sender, _optionId);
    }

    ///@dev Cancel Option after expiration and if it's worthless
    ///In practice, a function like this would probably get run by the protocol
    function optionExpiresWorthless(
        uint256 _optionId,
        uint256 _amount
    ) external optionExists(_optionId) {
        Option memory option = optionIdToOption[_optionId];

        if (option.optionState != OptionState.Bought) revert WrongState(option.optionState);

        //etiher writer or buyer can cancel option after expiration if it is worthless
        if (
            optionIdToOption[_optionId].buyer != msg.sender
                || optionIdToOption[_optionId].writer != msg.sender
        ) {
            revert Unauthorized(msg.sender);
        }

        if (option.expiration > block.timestamp) revert WrongTime(option.expiration);
        if (option.optionType != OptionType.Call) revert WrongType(option.optionType);

        uint256 marketPriceInEth = priceFeed.getPriceFeed(_amount);

        //For call, if market < strike, call options expire worthless
        if (marketPriceInEth >= option.strike) revert WrongValue(marketPriceInEth);

        optionIdToOption[_optionId].optionState = OptionState.Cancelled;

        emit OptionExpiresWorthless(msg.sender, _optionId);
    }

    ///@dev Writer of the call option may collect their ETH collateral after option has expired and if it's worthless.
    function retrieveExpiredFunds(uint256 _optionId) external nonReentrant {
        Option memory option = optionIdToOption[_optionId];

        if (option.optionState != OptionState.Cancelled) revert WrongState(option.optionState);
        if (msg.sender != option.writer) revert Unauthorized(msg.sender);

        (bool paid,) = payable(msg.sender).call{value: option.collateral}("");
        if (!paid) revert TransferFailed();

        emit FundsRetrieved(msg.sender, _optionId, option.collateral);
    }

    receive() external payable {}
}