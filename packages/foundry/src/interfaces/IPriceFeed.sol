// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IPriceFeed {
    function getUnderlierPrice() external view returns (uint256 price);

    function getMarkPrice() external view returns (uint256 price);

    function getIndexPrice() external view returns (uint256 price);
}
