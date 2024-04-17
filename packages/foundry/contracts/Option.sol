// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
pragma experimental ABIEncoderV2;

// @dev: Required libs, needs to be flattened
import {SafeMath} from "./SafeMath.sol";
import {console} from "./console.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

// @note: Deriva-Option's Contract

/**
 * @notice This contract is not audited and should not be used in a production environment.
 * @dev ! To compile this contract, you need to config "viaIR = true" in foundry.toml
 *      or config '{"settings": {"viaIR": true}}' in remix's compiler_config.json
 *      to avoid a stack too deep error.
 */

contract Deriva is ReentrancyGuard {
    using SafeMath for uint256;

    /**
     * @dev fallback function to receive ether, did not use it in this contract
     */
    // fallback() external payable {}

    // TODO: to be completed
    // @dev: query this mapping by calling queryTokenActivated

    mapping(address => bool) tokenActivated;

    /**
     * @dev Currently DAI is the stablecoin of choice and the address cannot be edited by anyone
     *      to prevent users unable to complete their option trade cycles under any circumstance.
     *      If the DAI address changes, a new contract should be used by users.
     */

    IERC20 daiToken;

    // @note: mappings for sellers and buyers of options (database)
    // @dev: query this mapping by calling queryOrderbook

    mapping(address => mapping(address => mapping(bool => mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256)))))) orderbook;

    // @dev: query this mapping by calling queryPositions

    mapping(address => mapping(address => mapping(bool => mapping(uint256 => mapping(uint256 => uint256))))) positions;

    // TODO: to be completed
    // @dev: query this mapping by calling queryAllowances

    mapping(address => mapping(address => uint256)) private _allowances;

    constructor(address _daiAddr) {
        daiToken = IERC20(_daiAddr);
        tokenActivated[_daiAddr] = true;
    }

    // @note: Incrementing identifiers for orders. This number will be the last offer or purchase ID

    uint256 lastOrderId = 0;
    uint256 lastPurchaseId = 0;

    // @note: All events based on major function executions (purchase, offers, exercises and cancellations)

    /**
     * @notice Emitted when an option is purchased.
     * @param buyer The address of the buyer.
     * @param seller The address of the seller.
     * @param token The address of the token.
     * @param isCallOption Indicates whether the option is a call option (true) or a put option (false).
     * @param strikePrice The price at which the option can be exercised.
     * @param premium The price paid for the option.
     * @param expiry The expiration timestamp of the option.
     * @param amountPurchasing The amount of options being purchased.
     * @param purchaseId The unique identifier of the purchase.
     */

    event OptionPurchase(
        address buyer,
        address seller,
        address token,
        bool isCallOption,
        uint256 strikePrice,
        uint256 premium,
        uint256 expiry,
        uint256 amountPurchasing,
        uint256 purchaseId
    );

    /**
     * @notice Emitted when an option is offered for sale.
     * @param seller The address of the seller.
     * @param token The address of the token being traded.
     * @param isCallOption A boolean indicating whether it's a call option.
     * @param strikePrice The price at which the option can be exercised.
     * @param premium The premium amount for the option.
     * @param expiry The expiration timestamp of the option.
     * @param amountSelling The amount of the option being sold.
     * @param orderId The unique identifier for the order.
     */

    event OptionOffer(
        address seller,
        address token,
        bool isCallOption,
        uint256 strikePrice,
        uint256 premium,
        uint256 expiry,
        uint256 amountSelling,
        uint256 orderId
    );

    /**
     * @notice Emitted when an option is exercised.
     * @param optionId The unique identifier of the option.
     * @param exerciseCost The cost associated with exercising the option.
     * @param timestamp The timestamp when the option is exercised.
     */

    event OptionExercise(
        uint256 optionId,
        uint256 exerciseCost,
        uint256 timestamp
    );

    /**
     * @notice Emitted when tokens are transferred
     * @param from The address tokens are transferred from
     * @param to The address tokens are transferred to
     * @param value The amount of tokens being transferred
     * @param purchaseId Identifier of the purchase
     * @param timestamp The timestamp of the transfer
     */

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value,
        uint256 purchaseId,
        uint256 timestamp
    );

    /**
     * @notice Emitted when approval is given for a specific value and purchase ID.
     * @param owner The address that approves the transfer of tokens.
     * @param spender The address that is approved to spend the tokens.
     * @param value The amount of tokens approved for transfer.
     * @param purchaseId The ID of the purchase being approved.
     */

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value,
        uint256 purchaseId
    );

    // @note: Structures of offers and purchases
    /**
     * @notice Structure to represent an option offer.
     *          Address of the seller
     *          Address of the token
     *          Boolean indicating if it's a call option
     *          The strike price of the option
     *          The premium associated with the option
     *          Expiry timestamp of the option
     *          Amount of underlying token
     *          Timestamp when the offer was made
     *          Boolean indicating if the offer is still valid
     */

    struct optionOffer {
        address seller;
        address token;
        bool isCallOption;
        uint256 strikePrice;
        uint256 premium;
        uint256 expiry;
        uint256 amountUnderlyingToken;
        uint256 offeredTimestamp;
        bool isStillValid;
    }

    /**
     * @notice Structure for option purchase details.
     *          Address of the buyer
     *          Address of the seller
     *          Address of the token
     *          Indicates if it is a call option
     *          Price at which the option can be exercised
     *          Premium paid for the option
     *          Expiry timestamp for the option
     *          Amount of the underlying token
     *          Unique identifier for the offer
     *          Timestamp when the option was purchased
     *          Indicates if the option has been exercised
     */

    struct optionPurchase {
        address buyer;
        address seller;
        address token;
        bool isCallOption;
        uint256 strikePrice;
        uint256 premium;
        uint256 expiry;
        uint256 amountUnderlyingToken;
        uint256 offerId;
        uint256 purchasedTimestamp;
        bool exercised;
    }

    // @note: publicly available data for all purchases and sale offers
    // @dev: query this mapping by calling queryOptionPurchases

    mapping(uint256 => optionPurchase) public optionPurchases;

    // @dev: query this mapping by calling queryOptionOffers

    mapping(uint256 => optionOffer) public optionOffers;

    /**
     * @note: This allows a user or smart contract to create a sell option order
     *         that anyone else can fill (completely or partially)
     */

    /**
     * @notice Allows the seller to create and sell an option.
     * @param seller The address of the seller.
     * @param token The address of the token being used for the option.
     * @param isCallOption A boolean indicating whether it's a call option (true) or a put option (false).
     * @param strikePrice The price at which the option can be exercised.
     * @param _premiumPrice The price the buyer pays for the option.
     * @param _expirySeconds The expiration seconds of the option.
     * @param amountUnderlyingToken The amount of the underlying token.
     * @return orderIdentifier The identifier of the created option.
     */

    function sellOption(
        address seller,
        address token,
        bool isCallOption,
        uint256 strikePrice,
        uint256 _premiumPrice,
        uint256 _expirySeconds,
        uint256 amountUnderlyingToken
    ) public returns (uint256 orderIdentifier) {

        // @dev: log
        console.log("[sellOption]start");

        IERC20 underlyingToken = IERC20(token);

        uint256 expiry = getBlockTimestamp() + _expirySeconds;
        uint256 premium = _premiumPrice;

        // @note: Query the contract's token balance
        uint256 contractBalanceBeforeTransfer = underlyingToken.balanceOf(
            address(this)
        );

        // @dev: log
        console.log(
            "[sellOption]contractBalanceBeforeTransfer: ",
            contractBalanceBeforeTransfer
        );

        // @dev: log
        console.log(
            "[sellOption]underlyingToken balanceOf msg.sender[old]: ",
            underlyingToken.balanceOf(msg.sender)
        );

        // @dev: log
        console.log(
            "[sellOption]underlyingToken balanceOf address(this)[old]: ",
            underlyingToken.balanceOf(address(this))
        );

        // @note: Transfer token to contract
        underlyingToken.transferFrom(
            msg.sender,
            address(this),
            amountUnderlyingToken
        );

        // @dev: log
        console.log(
            "[sellOption]underlyingToken balanceOf msg.sender[new]: ",
            underlyingToken.balanceOf(msg.sender)
        );

        // @dev: log
        console.log(
            "[sellOption]underlyingToken balanceOf address(this)[new]: ",
            underlyingToken.balanceOf(address(this))
        );

        // @note: Query the contract's token balance after a transfer
        uint256 contractBalanceAfterTransfer = underlyingToken.balanceOf(
            address(this)
        );

        // @dev: log
        console.log(
            "[sellOption]contractBalanceAfterTransfer: ",
            contractBalanceAfterTransfer
        );

        require(
            contractBalanceAfterTransfer >=
                (contractBalanceBeforeTransfer.add(amountUnderlyingToken)),
            "[sellOption]Could not transfer the amount from msg.sender that was requested"
        );

        // @dev: log
        console.log(
            "[sellOption]queryOrderbook[old]: ",
            queryOrderbook(
                seller,
                token,
                isCallOption,
                strikePrice,
                premium,
                expiry
            )
        );

        if (
            orderbook[seller][token][isCallOption][strikePrice][premium][
                expiry
            ] == 0
        ) {
            orderbook[seller][token][isCallOption][strikePrice][premium][
                expiry
            ] = amountUnderlyingToken;
        } else {
            orderbook[seller][token][isCallOption][strikePrice][premium][
                expiry
            ] += amountUnderlyingToken;
        }

        // @dev: log
        console.log(
            "[sellOption]queryOrderbook[new]: ",
            queryOrderbook(
                seller,
                token,
                isCallOption,
                strikePrice,
                premium,
                expiry
            )
        );

        lastOrderId = lastOrderId.add(1);

        optionOffers[lastOrderId] = optionOffer(
            seller,
            token,
            isCallOption,
            strikePrice,
            premium,
            expiry,
            amountUnderlyingToken,
            block.timestamp,
            true
        );

        emit OptionOffer(
            seller,
            token,
            isCallOption,
            strikePrice,
            premium,
            expiry,
            amountUnderlyingToken,
            lastOrderId
        );

        // @dev: log
        console.log("[sellOption]end");

        return lastOrderId;
    }

    // @note: This allows a user to immediately purchase an option based on the Id of an offer

    /**
     * @notice Facilitates the purchase of an option by its ID.
     * @param buyer The address of the buyer.
     * @param offerId The ID of the option offer.
     * @param amountPurchasing The amount of option being purchased.
     * @return purchaseResult Whether the purchase was successful.
     */

    function buyOptionByID(
        address buyer,
        uint256 offerId,
        uint256 amountPurchasing
    ) public returns (bool purchaseResult) {

        // @dev: log
        console.log("[buyOptionByID]start");

        require(
            optionOffers[offerId].isStillValid == true,
            "[buyOptionByID]This option is no longer valid"
        );

        optionOffer memory opData = optionOffers[offerId];

        bool optionIsBuyable = isOptionBuyable(
            opData.seller,
            opData.token,
            opData.isCallOption,
            opData.strikePrice,
            opData.premium,
            opData.expiry,
            amountPurchasing
        );

        // @dev: log
        console.log("[buyOptionByID]optionIsBuyable: ", optionIsBuyable);

        require(
            optionIsBuyable,
            "[buyOptionByID]This option is not buyable. Please check the seller's offer information"
        );
        require(
            amountPurchasing <= opData.amountUnderlyingToken,
            "[buyOptionByID]There is not enough inventory for this order"
        );

        uint256 orderSize = opData.premium.mul(amountPurchasing);

        // @dev: log
        console.log("[buyOptionByID]orderSize: ", orderSize);

        // @dev: log
        console.log(
            "[buyOptionByID]daiToken balanceOf msg.sender[old]: ",
            daiToken.balanceOf(msg.sender)
        );

        // @dev: log
        console.log(
            "[buyOptionByID]daiToken balanceOf opData.seller[old]: ",
            daiToken.balanceOf(opData.seller)
        );

        require(
            daiToken.transferFrom(msg.sender, opData.seller, orderSize),
            "[buyOptionByID]Please ensure that you have approved this contract to handle your DAI (error)"
        );

        // @dev: log
        console.log(
            "[buyOptionByID]daiToken balanceOf msg.sender[new]: ",
            daiToken.balanceOf(msg.sender)
        );

        // @dev: log
        console.log(
            "[buyOptionByID]daiToken balanceOf opData.seller[new]: ",
            daiToken.balanceOf(opData.seller)
        );

        // @dev: log
        console.log(
            "[buyOptionByID]queryOrderbook[old]: ",
            queryOrderbook(
                opData.seller,
                opData.token,
                opData.isCallOption,
                opData.strikePrice,
                opData.premium,
                opData.expiry
            )
        );

        // @dev: log
        console.log("[buyOptionByID]amountPurchasing[sub]: ", amountPurchasing);

        //@dev: edited
        orderbook[opData.seller][opData.token][opData.isCallOption][
            opData.strikePrice
        ][opData.premium][opData.expiry] = orderbook[opData.seller][
            opData.token
        ][opData.isCallOption][opData.strikePrice][opData.premium][
            opData.expiry
        ].sub(amountPurchasing);

        // @dev: log
        console.log(
            "[buyOptionByID]queryOrderbook[new]: ",
            queryOrderbook(
                opData.seller,
                opData.token,
                opData.isCallOption,
                opData.strikePrice,
                opData.premium,
                opData.expiry
            )
        );

        // @dev: log
        console.log(
            "[buyOptionByID]queryPositions[old]: ",
            queryPositions(
                buyer,
                opData.token,
                opData.isCallOption,
                opData.strikePrice,
                opData.expiry
            )
        );

        // @dev: log
        console.log("[buyOptionByID]amountPurchasing[add]: ", amountPurchasing);

        // @dev: edited
        positions[buyer][opData.token][opData.isCallOption][opData.strikePrice][
            opData.expiry
        ] = positions[buyer][opData.token][opData.isCallOption][
            opData.strikePrice
        ][opData.expiry].add(amountPurchasing);

        // @dev: log
        console.log(
            "[buyOptionByID]queryPositions[new]: ",
            queryPositions(
                buyer,
                opData.token,
                opData.isCallOption,
                opData.strikePrice,
                opData.expiry
            )
        );

        lastPurchaseId = lastPurchaseId.add(1);

        // @dev: log
        console.log("[buyOptionByID]lastPurchaseId: ", lastPurchaseId);

        // @dev: edited
        optionOffers[offerId].isStillValid = false;

        optionPurchases[lastPurchaseId] = optionPurchase(
            buyer,
            opData.seller,
            opData.token,
            opData.isCallOption,
            opData.strikePrice,
            opData.premium,
            opData.expiry,
            amountPurchasing,
            offerId,
            block.timestamp,
            false
        );

        emit OptionPurchase(
            buyer,
            opData.seller,
            opData.token,
            opData.isCallOption,
            opData.strikePrice,
            opData.premium,
            opData.expiry,
            amountPurchasing,
            lastPurchaseId
        );

        // @dev: log
        console.log("[buyOptionByID]end");

        return true;
    }

    // @note: This allows a user to immediately purchase an option based on the seller and offer information

    /**
     * @notice Allows a buyer to purchase an option by specifying the exact premium and expiry.
     * @param buyer The address of the buyer.
     * @param seller The address of the seller.
     * @param token The address of the token being used.
     * @param isCallOption Boolean indicating whether it's a call option or not.
     * @param strikePrice The strike price of the option.
     * @param premium The premium amount for the option.
     * @param expiry The expiry timestamp for the option.
     * @param amountPurchasing The amount of options being purchased.
     * @return purchaseResult Boolean indicating the purchase result.
     */

    function buyOptionByExactPremiumAndExpiry(
        address buyer,
        address seller,
        address token,
        bool isCallOption,
        uint256 strikePrice,
        uint256 premium,
        uint256 expiry,
        uint256 amountPurchasing
    ) public returns (bool purchaseResult) {

        // @dev: log
        console.log("[buyOptionByExactPremiumAndExpiry]start");

        bool optionIsBuyable = isOptionBuyable(
            seller,
            token,
            isCallOption,
            strikePrice,
            premium,
            expiry,
            amountPurchasing
        );

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]optionIsBuyable: ",
            optionIsBuyable
        );

        require(
            optionIsBuyable,
            "[buyOptionByExactPremiumAndExpiry]This option is not buyable. Please check the seller's offer information"
        );

        uint256 amountSelling = orderbook[seller][token][isCallOption][
            strikePrice
        ][premium][expiry];

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]amountSelling: ",
            amountSelling
        );

        require(
            amountPurchasing <= amountSelling,
            "[buyOptionByExactPremiumAndExpiry]There is not enough inventory for this order"
        );

        uint256 orderSize = premium.mul(amountPurchasing);

        // @dev: log
        console.log("[buyOptionByExactPremiumAndExpiry]orderSize: ", orderSize);

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]daiToken balanceOf msg.sender[old]: ",
            daiToken.balanceOf(msg.sender)
        );

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]daiToken balanceOf seller[old]: ",
            daiToken.balanceOf(seller)
        );

        require(
            daiToken.transferFrom(msg.sender, seller, orderSize),
            "[buyOptionByExactPremiumAndExpiry]Please ensure that you have approved this contract to handle your DAI (error)"
        );

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]daiToken balanceOf msg.sender[new]: ",
            daiToken.balanceOf(msg.sender)
        );

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]daiToken balanceOf seller[new]: ",
            daiToken.balanceOf(seller)
        );

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]queryOrderbook[old]: ",
            queryOrderbook(
                seller,
                token,
                isCallOption,
                strikePrice,
                premium,
                expiry
            )
        );

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]amountPurchasing[sub]: ",
            amountPurchasing
        );

        orderbook[seller][token][isCallOption][strikePrice][premium][
            expiry
        ] = orderbook[seller][token][isCallOption][strikePrice][premium][expiry]
            .sub(amountPurchasing);

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]queryOrderbook[new]: ",
            queryOrderbook(
                seller,
                token,
                isCallOption,
                strikePrice,
                premium,
                expiry
            )
        );

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]queryPositions[old]: ",
            queryPositions(buyer, token, isCallOption, strikePrice, expiry)
        );

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]amountPurchasing[add]: ",
            amountPurchasing
        );

        positions[buyer][token][isCallOption][strikePrice][expiry] = positions[
            buyer
        ][token][isCallOption][strikePrice][expiry].add(amountPurchasing);

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]queryPositions[new]: ",
            queryPositions(buyer, token, isCallOption, strikePrice, expiry)
        );

        lastPurchaseId = lastPurchaseId.add(1);

        // @dev: log
        console.log(
            "[buyOptionByExactPremiumAndExpiry]lastPurchaseId: ",
            lastPurchaseId
        );

        // @dev: edited
        // @dev: Set optionPurchase.offerId to 0
        optionPurchases[lastPurchaseId] = optionPurchase(
            buyer,
            seller,
            token,
            isCallOption,
            strikePrice,
            premium,
            expiry,
            amountPurchasing,
            0,
            block.timestamp,
            false
        );

        emit OptionPurchase(
            buyer,
            seller,
            token,
            isCallOption,
            strikePrice,
            premium,
            expiry,
            amountPurchasing,
            lastPurchaseId
        );

        // @dev: log
        console.log("[buyOptionByExactPremiumAndExpiry]end");

        return true;
    }

    /**
     * @note: Allows anyone to attempt to exercise an option after its exercise date.
     *       This can be done by a bot of the service provider or the user themselves
     */

    // TODO: to be tested

    /**
     * @notice Allows the holder of the option to exercise it.
     * @param purchaseId The unique identifier of the option purchase.
     * @return exerciseResult A boolean indicating whether the option was successfully exercised.
     */
    function exerciseOption(
        uint256 purchaseId
    ) public returns (bool exerciseResult) {

        // @dev: log
        console.log("[exerciseOption]start");

        require(
            optionPurchases[purchaseId].exercised == false,
            "[exerciseOption]This option has already been exercised"
        );

        // TODO: Add valid exercising option time

        require(
            optionPurchases[purchaseId].expiry >= block.timestamp,
            "[exerciseOption]This option has not reached its exercise timestamp yet"
        );

        optionPurchase memory opData = optionPurchases[purchaseId];

        // @dev: log
        console.log("[exerciseOption]opData: ");

        // @dev: log
        console.log("[exerciseOption]buyer: ", opData.buyer);

        // @dev: log
        console.log("[exerciseOption]seller: ", opData.seller);

        // @dev: log
        console.log("[exerciseOption]token: ", opData.token);

        // @dev: log
        console.log("[exerciseOption]isCallOption: ", opData.isCallOption);

        // @dev: log
        console.log("[exerciseOption]strikePrice: ", opData.strikePrice);

        // @dev: log
        console.log("[exerciseOption]premium: ", opData.premium);

        // @dev: log
        console.log("[exerciseOption]expiry: ", opData.expiry);

        // @dev: log
        console.log(
            "[exerciseOption]amountUnderlyingToken: ",
            opData.amountUnderlyingToken
        );

        // @dev: log
        console.log("[exerciseOption]offerId: ", opData.offerId);

        // @dev: log
        console.log(
            "[exerciseOption]purchasedTimestamp: ",
            opData.purchasedTimestamp
        );

        // @dev: log
        console.log("[exerciseOption]exercised: ", opData.exercised);

        address underlyingAddress = opData.token;
        IERC20 underlyingToken = IERC20(underlyingAddress);

        uint256 amountDAIToPay = opData.amountUnderlyingToken.mul(
            opData.strikePrice
        );

        // @dev: log
        console.log("[exerciseOption]amountDAIToPay: ", amountDAIToPay);

        // @dev: log
        console.log(
            "[exerciseOption]daiToken balanceOf opData.buyer[old]: ",
            daiToken.balanceOf(opData.buyer)
        );

        // @dev: log
        console.log(
            "[exerciseOption]daiToken balanceOf opData.seller[old]: ",
            daiToken.balanceOf(opData.seller)
        );

        require(
            daiToken.transferFrom(opData.buyer, opData.seller, amountDAIToPay),
            "[exerciseOption]Did the buyer approve this contract to handle DAI or have enough DAI to exercise?"
        );

        // @dev: log
        console.log(
            "[exerciseOption]daiToken balanceOf opData.buyer[new]: ",
            daiToken.balanceOf(opData.buyer)
        );

        // @dev: log
        console.log(
            "[exerciseOption]daiToken balanceOf opData.seller[new]: ",
            daiToken.balanceOf(opData.seller)
        );

        optionPurchases[purchaseId].exercised = true;

        // @dev: log
        console.log(
            "[exerciseOption]exercised: ",
            optionPurchases[purchaseId].exercised
        );

        // @dev: log
        console.log(
            "[exerciseOption]underlyingToken balanceOf address(this)[old]: ",
            underlyingToken.balanceOf(address(this))
        );

        // @dev: log
        console.log(
            "[exerciseOption]underlyingToken balanceOf opData.buyer[old]: ",
            underlyingToken.balanceOf(opData.buyer)
        );

        underlyingToken.transfer(opData.buyer, opData.amountUnderlyingToken);

        // @dev: log
        console.log(
            "[exerciseOption]underlyingToken balanceOf address(this)[new]: ",
            underlyingToken.balanceOf(address(this))
        );

        // @dev: log
        console.log(
            "[exerciseOption]underlyingToken balanceOf opData.buyer[new]: ",
            underlyingToken.balanceOf(opData.buyer)
        );

        emit OptionExercise(purchaseId, amountDAIToPay, block.timestamp);

        // @dev: log
        console.log("[exerciseOption]end");

        return true;
    }

    // @note: This allows for the exercising of many options with a single transaction

    /**
     * @notice Exercise multiple options based on their purchase IDs.
     * @param purchaseIds An array of purchase IDs to exercise.
     * @return exerciseResult A boolean indicating the success of the operation.
     */

    function exerciseOptions(
        uint256[] memory purchaseIds
    ) public returns (bool exerciseResult) {
        // @dev: log

        console.log("[exerciseOptions]start");

        for (uint256 i = 0; i < purchaseIds.length; i++) {
            exerciseOption(purchaseIds[i]);
        }

        // @dev: log
        console.log("[exerciseOptions]end");

        return true;
    }

    // TODO: Handle overdue option

    /**
     *@note: This allows a seller to cancel all or the remainder of an option offer
     *      and redeem their underlying. A seller cannot redeem the tokens
     *      that are needed by a user who already has purchased part of the offer
     */

    // TODO: to be tested

    /**
     * @notice Allows the seller to cancel an option offer.
     * @param offerId The ID of the option offer to be canceled.
     * @return cancelResult A boolean indicating whether the cancellation was successful.
     */

    function cancelOptionOffer(
        uint256 offerId
    ) public returns (bool cancelResult) {

        // @dev: log
        console.log("[cancelOptionOffer]start");

        // @note: msg.sender is seller

        require(
            optionOffers[offerId].seller == msg.sender,
            "[cancelOptionOffer]The msg.sender has to be the seller"
        );
        require(
            optionOffers[offerId].isStillValid == true,
            "[cancelOptionOffer]This option is no longer valid"
        );

        uint256 amountUnderlyingToReturn = orderbook[msg.sender][
            optionOffers[offerId].token
        ][optionOffers[offerId].isCallOption][
            optionOffers[offerId].strikePrice
        ][optionOffers[offerId].premium][optionOffers[offerId].expiry];

        // @dev: log
        console.log(
            "[cancelOptionOffer]amountUnderlyingToReturn: ",
            amountUnderlyingToReturn
        );

        address underlyingAddress = optionOffers[offerId].token;
        IERC20 underlyingToken = IERC20(underlyingAddress);

        orderbook[msg.sender][optionOffers[offerId].token][
            optionOffers[offerId].isCallOption
        ][optionOffers[offerId].strikePrice][optionOffers[offerId].premium][
            optionOffers[offerId].expiry
        ] = 0;

        optionOffers[offerId].isStillValid = false;

        // @dev: log
        console.log(
            "[cancelOptionOffer]underlyingToken balanceOf address(this)[old]: ",
            underlyingToken.balanceOf(address(this))
        );

        // @dev: log
        console.log(
            "[cancelOptionOffer]underlyingToken balanceOf msg.sender[old]: ",
            underlyingToken.balanceOf(msg.sender)
        );

        underlyingToken.transfer(msg.sender, amountUnderlyingToReturn);

        // @dev: log
        console.log(
            "[cancelOptionOffer]underlyingToken balanceOf address(this)[new]: ",
            underlyingToken.balanceOf(address(this))
        );

        // @dev: log
        console.log(
            "[cancelOptionOffer]underlyingToken balanceOf msg.sender[new]: ",
            underlyingToken.balanceOf(msg.sender)
        );

        // @dev: log
        console.log("[cancelOptionOffer]end");

        return true;
    }

    // @note: This allows a user to know if an option is purchasable based on the seller and offer information

    /**
     * @notice Check if an option is buyable based on the specified parameters.
     * @param seller The address of the seller.
     * @param token The address of the token.
     * @param isCallOption A boolean indicating whether the option is a call option.
     * @param strikePrice The strike price of the option.
     * @param premium The premium of the option.
     * @param expiry The expiry timestamp of the option.
     * @param amountPurchasing The amount of the option being purchased.
     * @return isBuyable A boolean indicating whether the option is buyable.
     */

    function isOptionBuyable(
        address seller,
        address token,
        bool isCallOption,
        uint256 strikePrice,
        uint256 premium,
        uint256 expiry,
        uint256 amountPurchasing
    ) public view returns (bool isBuyable) {
        if (
            orderbook[seller][token][isCallOption][strikePrice][premium][
                expiry
            ] >= amountPurchasing
        ) {
            isBuyable = true;
        } else {
            isBuyable = false;
        }
        return isBuyable;
    }

    // TODO: to be completed and tested

    /**
     * @dev Internal function for transferring options between addresses.
     * @param sender The address of the sender.
     * @param recipient The address of the recipient.
     * @param amount The amount of options to transfer.
     * @param purchaseId The ID of the option purchase.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount,
        uint256 purchaseId
    ) internal {

        // @dev: log
        console.log("[_transfer]start");

        // @note: internal transfer function

        require(
            optionPurchases[purchaseId].buyer == sender,
            "[_transfer]The sender must own the option"
        );
        require(
            optionPurchases[purchaseId].amountUnderlyingToken >= amount,
            "[_transfer]Cannot transfer more than owned"
        );

        optionPurchase memory optData = optionPurchases[purchaseId];

        require(!optData.exercised, "cannot transfer an exercised option");

        // @note: adjust the position of the owner

        // @dev: log
        console.log(
            "[_transfer]queryPositions[old]: ",
            queryPositions(
                sender,
                optData.token,
                optData.isCallOption,
                optData.strikePrice,
                optData.expiry
            )
        );

        // @dev: log
        console.log("[_transfer]amount[sub]: ", amount);

        positions[sender][optData.token][optData.isCallOption][
            optData.strikePrice
        ][optData.expiry] = positions[sender][optData.token][
            optData.isCallOption
        ][optData.strikePrice][optData.expiry].sub(amount);

        // @dev: log
        console.log(
            "[_transfer]queryPositions[new]: ",
            queryPositions(
                sender,
                optData.token,
                optData.isCallOption,
                optData.strikePrice,
                optData.expiry
            )
        );

        // @note: adjust the position of the receiver

        // @dev: log
        console.log(
            "[_transfer]queryPositions[old]: ",
            queryPositions(
                recipient,
                optData.token,
                optData.isCallOption,
                optData.strikePrice,
                optData.expiry
            )
        );

        // @dev: log
        console.log("[_transfer]amount[add]: ", amount);

        positions[recipient][optData.token][optData.isCallOption][
            optData.strikePrice
        ][optData.expiry] = positions[recipient][optData.token][
            optData.isCallOption
        ][optData.strikePrice][optData.expiry].add(amount);

        // @dev: log
        console.log(
            "[_transfer]queryPositions[new]: ",
            queryPositions(
                recipient,
                optData.token,
                optData.isCallOption,
                optData.strikePrice,
                optData.expiry
            )
        );

        emit Transfer(sender, recipient, amount, purchaseId, block.timestamp);

        // @dev: log
        console.log("[_transfer]end");
    }

    /**
     * @dev Transfers a specified amount of options to the recipient address.
     * @param recipient The address of the recipient.
     * @param amount The amount of options to transfer.
     * @param purchaseId The identifier of the purchase.
     */

    function transfer(
        address recipient,
        uint256 amount,
        uint256 purchaseId
    ) public returns (bool) {

        // @dev: log
        console.log("[transfer]start");

        // @note: Transfer the amount of options from the msg.sender to the recipient address

        _transfer(msg.sender, recipient, amount, purchaseId);

        // @dev: log
        console.log("[transfer]end");

        return true;
    }

    // TODO: to be completed and tested

    /**
     * @dev Transfers a specified amount of options from the sender's address to the recipient's address.
     * @param from The address from which the options are being transferred.
     * @param recipient The address receiving the options.
     * @param amount The amount of options being transferred.
     * @param purchaseId The ID of the option purchase.
     */

    function transferFrom(
        address from,
        address recipient,
        uint256 amount,
        uint256 purchaseId
    ) public returns (bool) {

        // @dev: log
        console.log("[transferFrom]start");

        // @note: Transfer the amount of options to the recipient address

        uint256 allowance = approval(from, recipient, purchaseId);

        require(allowance == 0, "[transferFrom]Not approved");
        require(
            allowance >= amount,
            "[transferFrom]Not approved for this amount"
        );

        _transfer(from, recipient, amount, purchaseId);

        approve(recipient, allowance.sub(amount), purchaseId);

        // @dev: log
        console.log("[transferFrom]end");

        return true;
    }

    // TODO: to be completed and tested

    /**
     * @dev Allows the designee to spend an amount of options
     * @param designee The address being approved to spend the options
     * @param amount The amount of options being approved for spending
     * @param purchaseId The unique ID of the option purchase
     * @return true if the approval was successful
     */

    function approve(
        address designee,
        uint256 amount,
        uint256 purchaseId
    ) public returns (bool) {

        // @dev: log
        console.log("[approve]start");

        // @note: allows the designee to spend an amount of options

        require(
            optionPurchases[purchaseId].buyer == msg.sender,
            "[approve]The sender must own the option"
        );
        require(
            optionPurchases[purchaseId].amountUnderlyingToken >= amount,
            "[approve]Cannot approve more than owned"
        );

        _allowances[msg.sender][designee] = amount;

        emit Approval(msg.sender, designee, amount, purchaseId);

        // @dev: log
        console.log("[approve]end");

        return true;
    }

    // TODO: to be completed and tested

    /**
     * @notice Return the amount of options the designee can spend
     * @param owner The address of the owner
     * @param designee The address of the designee
     * @param purchaseId The ID of the purchase
     * @return approvalAmount The amount of options the designee can spend
     */

    function approval(
        address owner,
        address designee,
        uint256 purchaseId
    ) public view returns (uint256 approvalAmount) {

        // @dev: log
        console.log("[approval]start");

        // @note: return the amount of options the designee can spend

        // @dev: purchaseId is not actually used
        // @dev: log
        console.log("[approval]purchaseId: ", purchaseId);

        // @dev: log
        console.log("[approval]end");

        return _allowances[owner][designee];
    }

    // @dev: query mapping
    /**
     * @notice Query the orderbook for a specific option based on seller, token, option type,
     *         strike price, premium, and expiry.
     * @param seller The address of the seller.
     * @param token The address of the token.
     * @param isCallOption Boolean indicating if it's a call option.
     * @param strikePrice The strike price of the option.
     * @param premium The premium of the option.
     * @param expiry The expiry timestamp of the option.
     * @return _orderbook The value in the orderbook for the specified option parameters.
     */

    function queryOrderbook(
        address seller,
        address token,
        bool isCallOption,
        uint256 strikePrice,
        uint256 premium,
        uint256 expiry
    ) public view returns (uint256 _orderbook) {
        return
            orderbook[seller][token][isCallOption][strikePrice][premium][
                expiry
            ];
    }

    // @dev: query mapping
    /**
     * @notice Queries the position of a buyer for a specific option.
     * @param buyer The address of the buyer.
     * @param token The address of the token associated with the option.
     * @param isCallOption Boolean indicating if it's a call option.
     * @param strikePrice The strike price of the option.
     * @param expiry The expiry timestamp of the option.
     * @return position The position of the buyer for the specified option.
     */

    function queryPositions(
        address buyer,
        address token,
        bool isCallOption,
        uint256 strikePrice,
        uint256 expiry
    ) public view returns (uint256 position) {
        return positions[buyer][token][isCallOption][strikePrice][expiry];
    }

    // // @dev: query mapping
    // /**
    //  * @notice Returns the details of a specific option purchase.
    //  * @param _purchaseId The unique identifier of the option purchase.
    //  * @return _buyer The address of the buyer.
    //  * @return _seller The address of the seller.
    //  * @return _token The address of the token.
    //  * @return _isCallOption Indicates whether it's a call option.
    //  * @return _strikePrice The price at which the option can be exercised.
    //  * @return _premium The price paid for the option.
    //  * @return _expiry The expiration timestamp of the option.
    //  * @return _amountUnderlyingToken The amount of underlying tokens involved in the option.
    //  * @return _offerId The identifier of the offer.
    //  * @return _purchasedTimestamp The timestamp at which the option was purchased.
    //  * @return _exercised Indicates whether the option has been exercised.
    //  */

    // function queryOptionPurchases(
    //     uint256 _purchaseId
    // )
    //     public
    //     view
    //     returns (
    //         address _buyer,
    //         address _seller,
    //         address _token,
    //         bool _isCallOption,
    //         uint256 _strikePrice,
    //         uint256 _premium,
    //         uint256 _expiry,
    //         uint256 _amountUnderlyingToken,
    //         uint256 _offerId,
    //         uint256 _purchasedTimestamp,
    //         bool _exercised
    //     )
    // {
    //     return (
    //         optionPurchases[_purchaseId].buyer,
    //         optionPurchases[_purchaseId].seller,
    //         optionPurchases[_purchaseId].token,
    //         optionPurchases[_purchaseId].isCallOption,
    //         optionPurchases[_purchaseId].strikePrice,
    //         optionPurchases[_purchaseId].premium,
    //         optionPurchases[_purchaseId].expiry,
    //         optionPurchases[_purchaseId].amountUnderlyingToken,
    //         optionPurchases[_purchaseId].offerId,
    //         optionPurchases[_purchaseId].purchasedTimestamp,
    //         optionPurchases[_purchaseId].exercised
    //     );
    // }

    // // @dev: query mapping
    // /**
    //  * @notice Queries information about a specific option offer.
    //  * @param offerId The ID of the option offer.
    //  * @return _seller The address of the seller.
    //  * @return _token The address of the token being traded.
    //  * @return _isCallOption Indicates if the option is a call option (true) or a put option (false).
    //  * @return _strikePrice The strike price of the option.
    //  * @return _premium The premium for the option.
    //  * @return _expiry The expiration timestamp of the option.
    //  * @return _amountUnderlyingToken The amount of underlying token being offered.
    //  * @return _offeredTimestamp The timestamp when the option offer was created.
    //  * @return _isStillValid Indicates if the option offer is still valid.
    //  */

    // function queryOptionOffers(
    //     uint256 offerId
    // )
    //     public
    //     view
    //     returns (
    //         address _seller,
    //         address _token,
    //         bool _isCallOption,
    //         uint256 _strikePrice,
    //         uint256 _premium,
    //         uint256 _expiry,
    //         uint256 _amountUnderlyingToken,
    //         uint256 _offeredTimestamp,
    //         bool _isStillValid
    //     )
    // {
    //     return (
    //         optionOffers[offerId].seller,
    //         optionOffers[offerId].token,
    //         optionOffers[offerId].isCallOption,
    //         optionOffers[offerId].strikePrice,
    //         optionOffers[offerId].premium,
    //         optionOffers[offerId].expiry,
    //         optionOffers[offerId].amountUnderlyingToken,
    //         optionOffers[offerId].offeredTimestamp,
    //         optionOffers[offerId].isStillValid
    //     );
    // }

    // @dev: query mapping
    /**
     * @notice Query if a token is activated.
     * @param token The address of the token to query.
     * @return isTokenActivated True if the token is activated, false otherwise.
     */

    function queryTokenActivated(
        address token
    ) public view returns (bool isTokenActivated) {
        return tokenActivated[token];
    }

    // @dev: query mapping
    /**
     * @notice Queries the allowance for a spender on behalf of the owner.
     * @param account The address of the owner.
     * @param spender The address of the spender.
     * @return allowance The allowance that `spender` can spend from `account`.
     */

    function queryAllowances(
        address account,
        address spender
    ) public view returns (uint256 allowance) {
        return _allowances[account][spender];
    }

    /**
     * @dev Get block timestamp
     * @return blockTimestamp The timestamp of the current block.
     */

    function getBlockTimestamp() public view returns (uint256 blockTimestamp) {
        return block.timestamp;
    }

    /**
     * @dev Get block number
     * @return blockNumber The number of the current block.
     */

    function getBlockNumber() public view returns (uint256 blockNumber) {
        return block.number;
    }

    /**
     * @dev Get dai token address
     * @return dai The address of the dai token.
     */

    function getDaiToken() public view returns (address dai) {
        return address(daiToken);
    }

    /**
     * @dev Get last order id
     * @return _lastOrderId The last order id.
     */

    function getLastOrderId() public view returns (uint256 _lastOrderId) {
        return lastOrderId;
    }

    /**
     * @dev Get last purchase id
     * @return _lastPurchaseId The last purchase id.
     */

    function getLastPurchaseId() public view returns (uint256 _lastPurchaseId) {
        return lastPurchaseId;
    }
}
