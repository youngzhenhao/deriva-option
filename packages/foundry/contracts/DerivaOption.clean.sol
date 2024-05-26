// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
pragma experimental ABIEncoderV2;
import {SafeMath} from "./SafeMath.sol";
import {console} from "./console.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {PriceFeedConsumer} from "./PriceFeedConsumer.sol";

contract DerivaOption is ReentrancyGuard {
    using SafeMath for uint256;
    mapping(address => bool) tokenActivated;
    IERC20 daiToken;
    mapping(address => mapping(address => mapping(bool => mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256)))))) orderbook;
    mapping(address => mapping(address => mapping(bool => mapping(uint256 => mapping(uint256 => uint256))))) positions;
    mapping(address => mapping(address => uint256)) private _allowances;
    error Unauthorized_ETH();
    error TransferFailed_ETH();
    error WrongValue_ETH(uint256 value);
    event OptionOpen_ETH(address indexed writer, uint256 id, uint256 expiration, uint256 value);
    event OptionBought_ETH(address indexed buyer, uint256 id);
    event OptionExercised_ETH(address indexed buyer, uint256 id);
    event OptionExpiresWorthless_ETH(address indexed buyer, uint256 Id);
    event FundsRetrieved_ETH(address indexed writer, uint256 id, uint256 value);
    PriceFeedConsumer internal priceFeed_ETH;
    IERC20 dai_ETH;
    uint256 public lastOptionId_ETH;
    mapping(uint256 => Option_ETH) public optionIdToOption_ETH;
    mapping(address => uint256[]) public tradersPosition_ETH;
    enum OptionState_ETH {Closed,Open,Bought,Cancelled,Exercised}
    struct Option_ETH {address writer;address buyer;uint256 strike;uint256 premiumDue;uint256 amount;uint256 expiration;uint256 collateral;OptionState_ETH optionState;bool isCallOption;}
    constructor(address _daiAddr, address _priceFeedAddr) {
        daiToken = IERC20(_daiAddr);
        tokenActivated[_daiAddr] = true;
        dai_ETH = IERC20(_daiAddr);
        priceFeed_ETH = PriceFeedConsumer(_priceFeedAddr);
    }
    uint256 lastOrderId = 0;
    uint256 lastPurchaseId = 0;
    event OptionPurchase(address buyer,address seller,address token,bool isCallOption,uint256 strikePrice,uint256 premium,uint256 expiry,uint256 amountPurchasing,uint256 purchaseId);
    event OptionOffer(address seller,address token,bool isCallOption,uint256 strikePrice,uint256 premium,uint256 expiry,uint256 amountSelling,uint256 orderId);
    event OptionExercise(uint256 optionId,uint256 exerciseCost,uint256 timestamp);
    event Transfer(address indexed from,address indexed to,uint256 value,uint256 purchaseId,uint256 timestamp);
    event Approval(address indexed owner,address indexed spender,uint256 value,uint256 purchaseId);
    struct optionOffer {address seller;address token;bool isCallOption;uint256 strikePrice;uint256 premium;uint256 expiry;uint256 amountUnderlyingToken;uint256 offeredTimestamp;bool isStillValid;}
    struct optionPurchase {address buyer;address seller;address token;bool isCallOption;uint256 strikePrice;uint256 premium;uint256 expiry;uint256 amountUnderlyingToken;uint256 offerId;uint256 purchasedTimestamp;bool exercised;}
    mapping(uint256 => optionPurchase) public optionPurchases;
    mapping(uint256 => optionOffer) public optionOffers;

    function sellOption(address seller,address token,bool isCallOption,uint256 strikePrice,uint256 _premiumPrice,uint256 _expirySeconds,uint256 amountUnderlyingToken) public returns (uint256 orderIdentifier) {
        IERC20 underlyingToken = IERC20(token);
        uint256 expiry = getBlockTimestamp() + _expirySeconds;
        uint256 premium = _premiumPrice;
        uint256 contractBalanceBeforeTransfer = underlyingToken.balanceOf(address(this));
        underlyingToken.transferFrom(msg.sender,address(this),amountUnderlyingToken);
        uint256 contractBalanceAfterTransfer = underlyingToken.balanceOf(address(this));
        require(contractBalanceAfterTransfer >=(contractBalanceBeforeTransfer.add(amountUnderlyingToken)),"[sellOption]contract balance insufficient.");
        if (orderbook[seller][token][isCallOption][strikePrice][premium][expiry] == 0) {
            orderbook[seller][token][isCallOption][strikePrice][premium][expiry] = amountUnderlyingToken;} else {
            orderbook[seller][token][isCallOption][strikePrice][premium][expiry] += amountUnderlyingToken;}
        lastOrderId = lastOrderId.add(1);
        optionOffers[lastOrderId] = optionOffer(seller,token,isCallOption,strikePrice,premium,expiry,amountUnderlyingToken,block.timestamp,true);
        emit OptionOffer(seller,token,isCallOption,strikePrice,premium,expiry,amountUnderlyingToken,lastOrderId);
        return lastOrderId;
    }

    function buyOptionByID(address buyer,uint256 offerId,uint256 amountPurchasing) public returns (bool purchaseResult) {
        require(optionOffers[offerId].isStillValid == true,"[buyOptionByID]option invalid");
        optionOffer memory opData = optionOffers[offerId];
        bool optionIsBuyable = isOptionBuyable(opData.seller,opData.token,opData.isCallOption,opData.strikePrice,opData.premium,opData.expiry,amountPurchasing);
        require(optionIsBuyable,"[buyOptionByID]This option is not buyable.");
        require(amountPurchasing <= opData.amountUnderlyingToken,"[buyOptionByID]not enough inventory.");
        uint256 orderSize = opData.premium.mul(amountPurchasing);
        require(daiToken.transferFrom(msg.sender, opData.seller, orderSize),"[buyOptionByID]transferFrom fail, need approved.");
        orderbook[opData.seller][opData.token][opData.isCallOption][opData.strikePrice][opData.premium][opData.expiry] = orderbook[opData.seller][opData.token][opData.isCallOption][opData.strikePrice][opData.premium][opData.expiry].sub(amountPurchasing);
        positions[buyer][opData.token][opData.isCallOption][opData.strikePrice][opData.expiry] = positions[buyer][opData.token][opData.isCallOption][opData.strikePrice][opData.expiry].add(amountPurchasing);
        lastPurchaseId = lastPurchaseId.add(1);
        optionOffers[offerId].isStillValid = false;
        optionPurchases[lastPurchaseId] = optionPurchase(buyer,opData.seller,opData.token,opData.isCallOption,opData.strikePrice,opData.premium,opData.expiry,amountPurchasing,offerId,block.timestamp,false);
        emit OptionPurchase(buyer,opData.seller,opData.token,opData.isCallOption,opData.strikePrice,opData.premium,opData.expiry,amountPurchasing,lastPurchaseId);
        return true;
    }

    function buyOptionByExactPremiumAndExpiry(address buyer,address seller,address token,bool isCallOption,uint256 strikePrice,uint256 premium,uint256 expiry,uint256 amountPurchasing) public returns (bool purchaseResult) {
        bool optionIsBuyable = isOptionBuyable(seller,token,isCallOption,strikePrice,premium,expiry,amountPurchasing);
        require(optionIsBuyable,"[buyOptionByExact]This option is not buyable.");
        uint256 amountSelling = orderbook[seller][token][isCallOption][strikePrice][premium][expiry];
        require(amountPurchasing <= amountSelling,"[buyOptionByExact]not enough inventory for this order");
        uint256 orderSize = premium.mul(amountPurchasing);
        require(daiToken.transferFrom(msg.sender, seller, orderSize),"[buyOptionByExact]transferFrom fail, need approved.");
        orderbook[seller][token][isCallOption][strikePrice][premium][expiry] = orderbook[seller][token][isCallOption][strikePrice][premium][expiry].sub(amountPurchasing);
        positions[buyer][token][isCallOption][strikePrice][expiry] = positions[buyer][token][isCallOption][strikePrice][expiry].add(amountPurchasing);
        lastPurchaseId = lastPurchaseId.add(1);
        optionPurchases[lastPurchaseId] = optionPurchase(buyer,seller,token,isCallOption,strikePrice,premium,expiry,amountPurchasing,0,block.timestamp,false);
        emit OptionPurchase(buyer,seller,token,isCallOption,strikePrice,premium,expiry,amountPurchasing,lastPurchaseId);
        return true;
    }

    function exerciseOption(uint256 purchaseId) public returns (bool exerciseResult) {
        require(optionPurchases[purchaseId].exercised == false,"[exerciseOption]This option has already been exercised");
        require(optionPurchases[purchaseId].expiry >= block.timestamp,"[exerciseOption]Wrong timestamp.");
        optionPurchase memory opData = optionPurchases[purchaseId];
        address underlyingAddress = opData.token;
        IERC20 underlyingToken = IERC20(underlyingAddress);
        uint256 amountDAIToPay = opData.amountUnderlyingToken.mul(opData.strikePrice);
        require(daiToken.transferFrom(opData.buyer, opData.seller, amountDAIToPay),"[exerciseOption]transferFrom fail, need approved.");
        optionPurchases[purchaseId].exercised = true;
        underlyingToken.transfer(opData.buyer, opData.amountUnderlyingToken);
        emit OptionExercise(purchaseId, amountDAIToPay, block.timestamp);
        return true;
    }

    function exerciseOptions(uint256[] memory purchaseIds) public returns (bool exerciseResult) {
        for (uint256 i = 0; i < purchaseIds.length; i++) {exerciseOption(purchaseIds[i]);}
        return true;
    }

    function cancelOptionOffer(uint256 offerId) public returns (bool cancelResult) {
        require(optionOffers[offerId].seller == msg.sender,"[cancelOptionOffer]The msg.sender has to be the seller");
        require(optionOffers[offerId].isStillValid == true,"[cancelOptionOffer]This option is no longer valid");
        uint256 amountUnderlyingToReturn = orderbook[msg.sender][optionOffers[offerId].token][optionOffers[offerId].isCallOption][optionOffers[offerId].strikePrice][optionOffers[offerId].premium][optionOffers[offerId].expiry];
        address underlyingAddress = optionOffers[offerId].token;
        IERC20 underlyingToken = IERC20(underlyingAddress);
        orderbook[msg.sender][optionOffers[offerId].token][optionOffers[offerId].isCallOption][optionOffers[offerId].strikePrice][optionOffers[offerId].premium][optionOffers[offerId].expiry] = 0;
        optionOffers[offerId].isStillValid = false;
        underlyingToken.transfer(msg.sender, amountUnderlyingToReturn);
        return true;
    }

    function isOptionBuyable(address seller,address token,bool isCallOption,uint256 strikePrice,uint256 premium,uint256 expiry,uint256 amountPurchasing) public view returns (bool isBuyable) {
        if (orderbook[seller][token][isCallOption][strikePrice][premium][expiry] >= amountPurchasing
        ) {isBuyable = true;} else {isBuyable = false;}return isBuyable;}

    function _transfer(address sender,address recipient,uint256 amount,uint256 purchaseId) internal {
        require(optionPurchases[purchaseId].buyer == sender,"[_transfer]The sender must own the option");
        require(optionPurchases[purchaseId].amountUnderlyingToken >= amount,"[_transfer]Cannot transfer more than owned");
        optionPurchase memory optData = optionPurchases[purchaseId];
        require(!optData.exercised, "cannot transfer an exercised option");
        positions[sender][optData.token][optData.isCallOption][optData.strikePrice][optData.expiry] = positions[sender][optData.token][optData.isCallOption][optData.strikePrice][optData.expiry].sub(amount);
        positions[recipient][optData.token][optData.isCallOption][optData.strikePrice][optData.expiry] = positions[recipient][optData.token][optData.isCallOption][optData.strikePrice][optData.expiry].add(amount);
        emit Transfer(sender, recipient, amount, purchaseId, block.timestamp);
    }

    function transfer(address recipient,uint256 amount,uint256 purchaseId) public returns (bool) {
        _transfer(msg.sender, recipient, amount, purchaseId);
        return true;
    }

    function transferFrom(address from,address recipient,uint256 amount,uint256 purchaseId) public returns (bool) {
        uint256 allowance = approval(from, recipient, purchaseId);
        require(allowance == 0, "[transferFrom]Not approved");
        require(allowance >= amount,"[transferFrom]Not approved for this amount");
        _transfer(from, recipient, amount, purchaseId);
        approve(recipient, allowance.sub(amount), purchaseId);
        return true;
    }

    function approve(address designee,uint256 amount,uint256 purchaseId) public returns (bool) {
        require(optionPurchases[purchaseId].buyer == msg.sender,"[approve]The sender must own the option");
        require(optionPurchases[purchaseId].amountUnderlyingToken >= amount,"[approve]Cannot approve more than owned");
        _allowances[msg.sender][designee] = amount;
        emit Approval(msg.sender, designee, amount, purchaseId);
        return true;
    }

    function approval(address owner,address designee,uint256 purchaseId) public view returns (uint256 approvalAmount) {
        return _allowances[owner][designee];}
    function queryOrderbook(address seller,address token,bool isCallOption,uint256 strikePrice,uint256 premium,uint256 expiry) public view returns (uint256 _orderbook) {
        return orderbook[seller][token][isCallOption][strikePrice][premium][ expiry ];}
    function queryPositions(address buyer,address token,bool isCallOption,uint256 strikePrice,uint256 expiry) public view returns (uint256 position) {
        return positions[buyer][token][isCallOption][strikePrice][expiry];}
    function queryTokenActivated(address token) public view returns (bool isTokenActivated) {return tokenActivated[token];}
    function queryAllowances(address account,address spender) public view returns (uint256 allowance) {return _allowances[account][spender];}
    function getBlockTimestamp() public view returns (uint256 blockTimestamp) {return block.timestamp;}
    function getBlockNumber() public view returns (uint256 blockNumber) {return block.number;}
    function getDaiToken() public view returns (address dai) {return address(daiToken);}
    function getLastOrderId() public view returns (uint256 _lastOrderId) {return lastOrderId;}
    function getLastPurchaseId() public view returns (uint256 _lastPurchaseId) {return lastPurchaseId;}

    function sellOption_ETH(uint256 _strike, uint256 _premiumDue, uint _amount, uint256 _secondsToExpiry, bool _isCallOption)external payable returns (uint256){
        if (msg.value != _amount) revert WrongValue_ETH(msg.value);
        ++lastOptionId_ETH;
        optionIdToOption_ETH[lastOptionId_ETH] = Option_ETH(msg.sender,address(0x1),_strike,_premiumDue,_amount,block.timestamp + _secondsToExpiry,msg.value,OptionState_ETH.Open,_isCallOption);
        tradersPosition_ETH[msg.sender].push(lastOptionId_ETH);
        emit OptionOpen_ETH(msg.sender, lastOptionId_ETH, block.timestamp + _secondsToExpiry, msg.value);
        return lastOptionId_ETH;
    }

    function buyOption_ETH(uint256 _optionId) external nonReentrant {
        Option_ETH memory option = optionIdToOption_ETH[_optionId];
        if (option.optionState != OptionState_ETH.Open) revert Unauthorized_ETH();
        if (option.expiration < block.timestamp) revert Unauthorized_ETH();
        uint256 premiumDai = option.premiumDue.mul(option.amount);
        bool paid = dai_ETH.transferFrom(msg.sender, option.writer, premiumDai);
        if (!paid) revert TransferFailed_ETH();
        optionIdToOption_ETH[_optionId].buyer = msg.sender;
        optionIdToOption_ETH[_optionId].optionState = OptionState_ETH.Bought;
        tradersPosition_ETH[msg.sender].push(_optionId);
        emit OptionBought_ETH(msg.sender, _optionId);
    }

    function exerciseOption_ETH(uint256 _optionId) external payable nonReentrant{
        if (optionIdToOption_ETH[_optionId].writer == address(0)) {revert WrongValue_ETH(_optionId);}
        Option_ETH memory option = optionIdToOption_ETH[_optionId];
        if (msg.sender != option.buyer) {console.log("[exercise_ETH]Wrong msg.sender.");revert Unauthorized_ETH();}
        if (option.expiration < block.timestamp) {console.log("[exercise_ETH]Wrong Time.");revert Unauthorized_ETH();}
        uint256 _amount = optionIdToOption_ETH[_optionId].amount;
        uint256 marketPriceInEth = priceFeed_ETH.getPriceFeed(_amount);
        if (optionIdToOption_ETH[_optionId].isCallOption) {
            if(marketPriceInEth <= option.strike.mul(_amount)) {console.log("[exercise_ETH]marketPriceInEth <= option.strike");revert Unauthorized_ETH();}
        }else {if(marketPriceInEth >= option.strike.mul(_amount)) {console.log("[exercise_ETH]marketPriceInEth >= option.strike");revert Unauthorized_ETH();}}
        uint256 strikeInDai = _amount.mul(option.strike);
        console.log("[exercise_ETH]strikeInDai: ", strikeInDai);
        bool paid = dai_ETH.transferFrom(msg.sender, option.writer, strikeInDai);
        if (!paid) revert TransferFailed_ETH();
        (paid,) = payable(msg.sender).call{value: option.amount}("");
        if (!paid) revert TransferFailed_ETH();
        optionIdToOption_ETH[_optionId].optionState = OptionState_ETH.Exercised;
        emit OptionExercised_ETH(msg.sender, _optionId);
    }

    function optionExpiresWorthless_ETH(uint256 _optionId) external {
        if (optionIdToOption_ETH[_optionId].writer == address(0)) {revert WrongValue_ETH(_optionId);}
        Option_ETH memory option = optionIdToOption_ETH[_optionId];
        if (option.optionState != OptionState_ETH.Bought) revert Unauthorized_ETH();
        if (optionIdToOption_ETH[_optionId].buyer != msg.sender || optionIdToOption_ETH[_optionId].writer != msg.sender) {revert Unauthorized_ETH();}
        if (option.expiration > block.timestamp) revert Unauthorized_ETH();
        if (! option.isCallOption) revert Unauthorized_ETH();
        uint256 marketPriceInEth = priceFeed_ETH.getPriceFeed(optionIdToOption_ETH[_optionId].amount);
        if (option.isCallOption){if (marketPriceInEth >= option.strike.mul(optionIdToOption_ETH[_optionId].amount)) revert Unauthorized_ETH();}else {if (marketPriceInEth <= option.strike.mul(optionIdToOption_ETH[_optionId].amount)) revert Unauthorized_ETH();}
        optionIdToOption_ETH[_optionId].optionState = OptionState_ETH.Cancelled;
        emit OptionExpiresWorthless_ETH(msg.sender, _optionId);
    }

    function retrieveExpiredFunds_ETH(uint256 _optionId) external nonReentrant {
        Option_ETH memory option = optionIdToOption_ETH[_optionId];
        if (option.optionState != OptionState_ETH.Cancelled) revert Unauthorized_ETH();
        if (msg.sender != option.writer) revert Unauthorized_ETH();
        (bool paid,) = payable(msg.sender).call{value: option.amount}("");
        if (!paid) revert TransferFailed_ETH();
        emit FundsRetrieved_ETH(msg.sender, _optionId, option.amount);
    }
    receive() external payable {}
}
