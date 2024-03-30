// SPDX-License-Identifier: MIT
pragma solidity >=0.8.7 <0.9.0;

import "ds-test/test.sol";
import "forge-std/Vm.sol";

import "../src/mocks/MockV3Aggregator.sol";
import "../src/oracle/PriceFeedConsumer.sol";

contract PriceFeedConsumerTest is DSTest {
    Vm public constant vm = Vm(HEVM_ADDRESS);
    uint8 public constant DECIMALS = 18;
    int256 public constant INITIAL_ANSWER = 1e18;
    PriceFeedConsumer public priceFeed;
    MockV3Aggregator public mockV3Aggregator;

    function setUp() public {
        mockV3Aggregator = new MockV3Aggregator(DECIMALS, INITIAL_ANSWER);
        priceFeed = new PriceFeedConsumer(address(mockV3Aggregator));
    }

    //uint test
    function test_GetPriceFeed() public {
        uint256 price = priceFeed.getPriceFeed(1);
        assertTrue(price * 1e18 == uint256(INITIAL_ANSWER));
    }

    function testFail_GetPriceFeed() public {
        uint256 price = priceFeed.getPriceFeed(0);
        assertTrue(price * 1e18 == uint256(INITIAL_ANSWER));
    }
}
