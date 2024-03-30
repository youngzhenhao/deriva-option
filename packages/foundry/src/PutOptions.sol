// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {PriceFeedConsumer} from "./oracle/PriceFeedConsumer.sol";

///@title COVERED OPTIONS
///@author tobias
///@notice This Smart Contract allows for the buying/writing Cash-Secured Puts with ETH as the underlying.

/// As an Example, use Chainlink DAI/ETH Price Feed.
/// Puts: Let you sell an asset at a set price on a specific date.
/// Cash-Secured Put: The writer transfers ETH for collateral. Buyer pays premium w DAI.
/// Cash-Secured Put: At expiration, if market price less than strike, buyer has right to sell ETH at the strike. Settles w DAI.
/// All options have the following properties:
/// Strike price - The price at which the underlying asset can either be bought or sold.
/// Expiry - The date at which the option expires.
/// Premium - The price of the options contract.
/// Probable strategy for option writer:
/// Cash-secured Puts - Writer earns yield on cash (Bullish).

contract PutOptions is ReentrancyGuard {
    error Unauthorized();
    error TransferFailed();
    error OptionNotValid(uint256 _optionId);

    event PutOptionOpen(
        address indexed writer,
        uint256 id,
        uint256 expiration,
        uint256 value
    );
    event PutOptionBought(address indexed buyer, uint256 id);
    event PutOptionExercised(address indexed buyer, uint256 id);
    event OptionExpiresWorthless(address indexed buyer, uint256 Id);
    event FundsRetrieved(address indexed writer, uint256 id, uint256 value);

    PriceFeedConsumer internal priceFeed;
    IERC20 dai;
    uint256 public optionId;

    mapping(address => address) public tokenToEthFeed;
    mapping(uint256 => Option) public optionIdToOption;
    mapping(address => uint256[]) public tradersPosition;

    enum OptionState {
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
        if (optionIdToOption[id].writer == address(0))
            revert OptionNotValid(id);
        _;
    }

    modifier isValidOpenOption(uint256 id) {
        if (
            optionIdToOption[id].optionState != OptionState.Open ||
            optionIdToOption[id].expiration > block.timestamp
        ) revert OptionNotValid(id);
        _;
    }

    //CONSTRUCTOR
    constructor(address _daiAddr) {
        dai = IERC20(_daiAddr);
    }

    ///@dev Open a put option.
    ///ETH collateral(msg.value) must equal strike. In practice, there would be different strike options on the frontend.
    function sellPut(
        uint256 _strike,
        uint256 _premiumDue,
        uint256 _secondsToExpiry
    ) external payable {
        //To simplify, we only make one strike available, strike is the current marketprice.
        if (msg.value != _strike) {
            revert Unauthorized();
        }

        ++optionId;

        optionIdToOption[optionId] = Option(
            msg.sender,
            address(0),
            _strike,
            _premiumDue,
            block.timestamp + _secondsToExpiry,
            msg.value,
            OptionState.Open,
            OptionType.Put
        );

        tradersPosition[msg.sender].push(optionId);

        emit PutOptionOpen(
            msg.sender,
            optionId,
            block.timestamp + _secondsToExpiry,
            msg.value
        );
    }

    ///@dev Buy an available put option, for this example, we use DAI
    function buyPut(uint256 _optionId) external nonReentrant {
        Option memory option = optionIdToOption[_optionId];

        if (
            option.optionType != OptionType.Put ||
            option.optionState != OptionState.Open
        ) {
            revert Unauthorized();
        }

        //pay premium w DAI
        bool paid = dai.transferFrom(
            msg.sender,
            option.writer,
            option.premiumDue
        );
        if (!paid) revert TransferFailed();

        optionIdToOption[_optionId].buyer = msg.sender;
        optionIdToOption[_optionId].optionState = OptionState.Bought;
        tradersPosition[msg.sender].push(_optionId);

        emit PutOptionBought(msg.sender, _optionId);
    }

    ///@dev Buyer can exercise if spot < strike at expiration
    function exercisePutOption(uint256 _optionId, uint256 _amount)
        external
        payable
        optionExists(_optionId)
        nonReentrant
    {
        Option memory option = optionIdToOption[_optionId];

        require(msg.sender == option.buyer, "NOT BUYER");
        require(option.optionState == OptionState.Bought, "NEVER BOUGHT");
        require(option.expiration <= block.timestamp, "PUT NOT EXPIRED");

        uint256 marketPriceInEth = priceFeed.getPriceFeed(_amount);

        require(marketPriceInEth < option.strike, "NOT LESS THAN STRIKE");

        //convert strike to DAI to transfer
        uint256 marketPriceInDai = _amount / marketPriceInEth;

        //buyer gets to sell ETH for DAI at spot to option writer
        bool paid = dai.transferFrom(
            msg.sender,
            option.writer,
            marketPriceInDai
        );
        if (!paid) revert TransferFailed();

        //recall, for this example msg.value == strike == collateral
        (paid, ) = payable(msg.sender).call{value: option.collateral}("");
        if (!paid) revert TransferFailed();

        optionIdToOption[_optionId].optionState = OptionState.Exercised;

        emit PutOptionExercised(msg.sender, _optionId);
    }

    ///-----------------------------------------///
    ///--------------ADDITIONAL FUNCTIONS
    ///----------------------------------------///

    ///@dev Put options are worthless and can be cancelled if spot price is > strike
    function optionExpiresWorthless(uint256 _optionId, uint256 _amount)
        external
        optionExists(_optionId)
    {
        Option memory option = optionIdToOption[_optionId];

        require(option.optionState == OptionState.Bought, "NEVER BOUGHT");
        require(
            optionIdToOption[_optionId].buyer == msg.sender ||
                optionIdToOption[_optionId].writer == msg.sender,
            "NOT BUYER OR WRITER"
        );
        require(option.expiration < block.timestamp, "NOT EXPIRED");
        require(option.optionType == OptionType.Put, "NOT A PUT");

        uint256 marketPriceInEth = priceFeed.getPriceFeed(_amount);

        //For put, if market > strike, put options expire worthless
        require(
            marketPriceInEth > option.strike,
            "PRICE NOT GREATER THAN STRIKE"
        );
        optionIdToOption[_optionId].optionState = OptionState.Cancelled;

        emit OptionExpiresWorthless(msg.sender, _optionId);
    }

    function retrieveExpiredFunds(uint256 _optionId) external nonReentrant {
        Option memory option = optionIdToOption[_optionId];

        require(option.optionState == OptionState.Cancelled, "NOT CANCELLED");
        require(option.expiration < block.timestamp, "NOT EXPIRED");
        require(msg.sender == option.writer, "NOT WRITER");

        //if put option cancelled, writer can retrieve ETH collateral
        (bool paid, ) = payable(msg.sender).call{value: option.collateral}("");
        if (!paid) revert TransferFailed();

        emit FundsRetrieved(msg.sender, _optionId, option.collateral);
    }

    receive() external payable {}
}
