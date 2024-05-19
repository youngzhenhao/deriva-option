// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceFeedConsumer {
    AggregatorV3Interface internal immutable priceFeed;

    constructor(address _priceAggr) {
        priceFeed = AggregatorV3Interface(_priceAggr);
    }

    function getPriceFeed(uint256 _amount) public view returns (uint256) {
        (, int256 price,,,) = priceFeed.latestRoundData();
        return (uint256(price) * _amount) / 1e18;
    }
}
