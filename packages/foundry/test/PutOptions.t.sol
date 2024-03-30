// SPDX-License-Identifier: MIT
pragma solidity >=0.8.7 <0.9.0;

import "ds-test/test.sol";
import "forge-std/StdStorage.sol";
import "forge-std/console.sol";

import "../src/mocks/MockV3Aggregator.sol";
import "../src/mocks/MockERC20.sol";

import "../src/oracle/PriceFeedConsumer.sol";
import "../src/PutOptions.sol";

contract PutOptionsTest is DSTest {
    //Setup contracts
    Vm public constant vm = Vm(HEVM_ADDRESS);
    PutOptions public put;
    MockERC20 public dai;
    MockV3Aggregator public mockV3Aggregator;
    PriceFeedConsumer public priceFeed;

    //mock price feed
    uint8 public constant DECIMALS = 18;
    int256 public constant INITIAL_ANSWER = 1e18;

    //forge std lib
    using stdStorage for StdStorage;

    StdStorage public stdstore;

    //Events
    event PutOptionOpen(address indexed writer, uint256 id, uint256 expiration, uint256 value);
    event PutOptionBought(address indexed buyer, uint256 id);

    //Errors
    error Unauthorized();

    function setUp() public {
        dai = new MockERC20("DAI COIN", "DAI");
        put = new PutOptions(address(dai));
        mockV3Aggregator = new MockV3Aggregator(DECIMALS, INITIAL_ANSWER);
        priceFeed = new PriceFeedConsumer(address(mockV3Aggregator));

        dai.mint(address(this), 1e8);
        dai.approve(address(this), 1e8);
    }

    receive() external payable {}

    //contract addr checks
    function test_contractAddrPriceFeed() public {
        assertTrue(address(priceFeed) != address(0));
    }

    function test_contractAddrCallOptions() public {
        assertTrue(address(put) != address(0));
    }

    function test_contractAddrMockAggr() public {
        assertTrue(address(mockV3Aggregator) != address(0));
    }

    function test_contractAddrDai() public {
        console.log(address(dai));
        assertTrue(address(dai) != address(0));
    }

    //test dai check
    function test_daiBalance() public {
        uint256 preBal = dai.balanceOf(address(this));
        dai.mint(address(this), 1e8);
        uint256 postBal = dai.balanceOf(address(this));
        assertEq(preBal + 1e8, postBal);
    }

    //optionId check
    function test_WriteToOptionId() public {
        stdstore.target(address(put)).sig("optionId()").checked_write(100);
        assertEq(put.optionId(), 100);
    }

    function test_WriteToOptionIdFuzz(uint96 _id) public {
        stdstore.target(address(put)).sig("optionId()").checked_write(_id);
        assertEq(put.optionId(), _id);
    }

    //Create a put option
    function testFail_writePutOption() public {
        put.sellPut{value: 1 ether}(0, 1, 1);
    }

    function test_writePutOption() public {
        put.sellPut{value: 1 ether}(1 ether, 1, 1);
    }

    function test_emitOpenOption() public {
        vm.expectEmit(true, true, false, false);
        emit PutOptionOpen(address(this), 1, 1, 1 ether);
        put.sellPut{value: 1 ether}(1 ether, 1, 1);
    }

    function testFail_emitOpenOption() public {
        vm.expectEmit(true, true, false, false);
        emit PutOptionOpen(address(0x1), 1, 1, 1 ether);
        put.sellPut{value: 1 ether}(1 ether, 1, 1);
    }

    function testCannot_writePutOptionWithWrongValue() public {
        vm.expectRevert(Unauthorized.selector);
        put.sellPut{value: 1 ether}(1 wei, 1 wei, 60);
    }

    function test_writePutOptionFuzz(uint96 _strike, uint96 _premiumDue, uint96 _secondsToExpiry) public {
        _strike = 1 ether;
        put.sellPut{value: 1 ether}(_strike, _premiumDue, _secondsToExpiry);
    }

    //Buy a Put Option
    function test_buyPutOption() public {
        put.sellPut{value: 1 wei}(1 wei, 1 wei, 60);
        dai.approve(address(put), 1e8);
        put.buyPut(1);
    }

    function testFail_buyPutOption() public {
        put.sellPut{value: 1 wei}(1 wei, 1 wei, 60);
        dai.approve(address(put), 1e8);
        put.buyPut(7);
    }

    function test_emitBoughtOption() public {
        put.sellPut{value: 1 wei}(1 wei, 1, 1);
        dai.approve(address(put), 1e8);

        //check topic 1, but not data
        vm.expectEmit(true, false, false, false);
        //the event expected
        emit PutOptionBought(address(this), 1);
        //the event we get
        put.buyPut(1);
    }

    function testCannot_buyOptionWithWrongId(uint96 _id) public {
        vm.assume(_id > 1);
        vm.expectRevert(Unauthorized.selector);
        put.buyPut(_id);
    }

    //TODO: test chainlink price feed called in functions
}
