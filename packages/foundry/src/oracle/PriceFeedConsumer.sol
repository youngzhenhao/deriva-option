// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceFeedConsumer {
    AggregatorV3Interface internal immutable priceFeed;

    ///CHAINLINK PRICEFEEDS FOR EASE OF USE
    ///NETWORK: KOVAN
    ///EX: DAI/ETH Address: 0x22B58f1EbEDfCA50feF632bD73368b2FdA96D541
    ///NETWORK: RINKEBY
    ///EX: DAI/ETH Address: 0x74825DbC8BF76CC4e9494d0ecB210f676Efa001D

    // https://docs.chain.link/vrf/v2/subscription/supported-networks#sepolia-testnet
    // LINK Token	        0x779877A7B0D9E8603169DdbD7836e478b4624789
    // VRF Coordinator	    0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625
    // 150 gwei Key Hash	0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c

    constructor(address _priceFeed) {
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    function getPriceFeed(uint256 _amount) public view returns (uint256) {
        (, int256 price,,,) = priceFeed.latestRoundData();
        return (uint256(price) * _amount) / 1e18;
    }
}
