// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

interface IOption {
    function sellOption(address seller, address token, bool isCallOption, uint256 strikePrice, uint256 _premiumPrice, uint256 _expirySeconds, uint256 amountUnderlyingToken) external returns (uint256 orderIdentifier);

    function buyOptionByID(address buyer, uint256 offerId, uint256 amountPurchasing) external returns (bool purchaseResult);

    function buyOptionByExactPremiumAndExpiry(address buyer,address seller, address token, bool isCallOption, uint256 strikePrice, uint256 premium, uint256 expiry, uint256 amountPurchasing) external returns (bool purchaseResult);

    function exerciseOption(uint256 purchaseId) external returns (bool exerciseResult);

    function exerciseOptions(uint256[] memory purchaseIds) external returns (bool exerciseResult);

    function cancelOptionOffer(uint256 offerId)external returns (bool cancelResult);

    function isOptionBuyable(address seller, address token,bool isCallOption, uint256 strikePrice, uint256 premium, uint256 expiry, uint256 amountPurchasing) external view returns (bool isBuyable);

    function transfer(address recipient, uint256 amount, uint256 purchaseId) external returns (bool);

    function transferFrom(address from, address recipient, uint256 amount, uint256 purchaseId) external returns (bool);

    function approve(address designee, uint256 amount, uint256 purchaseId) external returns (bool);

    function approval(address owner, address designee, uint256 purchaseId) external view returns (uint256 approvalAmount);

    function queryOrderbook(address seller, address token, bool isCallOption, uint256 strikePrice, uint256 premium, uint256 expiry) external view returns (uint256 _orderbook);

    function queryPositions(address buyer, address token, bool isCallOption, uint256 strikePrice, uint256 expiry) external view returns (uint256 position);

    function queryTokenActivated(address token) external view returns (bool isTokenActivated);

    function queryAllowances(address account, address spender) external view returns (uint256 allowance);

    function getBlockTimestamp() external view returns (uint256 blockTimestamp);

    function getBlockNumber() external view returns (uint256 blockNumber);

    function getDaiToken() external view returns (address dai);

    function getLastOrderId() external view returns (uint256 _lastOrderId);

    function getLastPurchaseId() external view returns (uint256 _lastPurchaseId);
}
