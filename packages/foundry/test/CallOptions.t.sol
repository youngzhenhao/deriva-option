// SPDX-License-Identifier: MIT
pragma solidity >=0.8.7 <0.9.0;

import "ds-test/test.sol";
import "forge-std/StdStorage.sol";
import "forge-std/console.sol";

import "../src/mocks/MockV3Aggregator.sol";
import "../src/mocks/MockERC20.sol";

import "../src/oracle/PriceFeedConsumer.sol";
import "../src/CallOptions.sol";

contract CallOptionsTest is DSTest {
    //Setup contracts
    Vm public constant vm = Vm(HEVM_ADDRESS);
    CallOptions public call;
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
    event CallOptionOpen(address indexed writer, uint256 id, uint256 expiration, uint256 value);
    event CallOptionBought(address indexed buyer, uint256 id);

    //Errors
    error Unauthorized();

    function setUp() public {
        dai = new MockERC20("DAI COIN", "DAI");
        call = new CallOptions(address(dai));

        mockV3Aggregator = new MockV3Aggregator(DECIMALS, INITIAL_ANSWER);
        priceFeed = new PriceFeedConsumer(address(mockV3Aggregator));

        // call.Option storage option = call.Option({
        //     writer: msg.sender,
        //     buyer: msg.sender,
        //     strike: 1 ether,
        //     premiumDue: 0.001 ether,
        //     expiration: (uint40(block.timestamp) + 604800),
        //     collateral: 1 ether
        // });

        dai.mint(address(this), 1e18);
        dai.approve(address(this), 1e18);
    }

    receive() external payable {}

    //contract addr checks
    function test_contractAddrPriceFeed() public {
        assertTrue(address(priceFeed) != address(0));
    }

    function test_contractAddrCallOptions() public {
        assertTrue(address(call) != address(0));
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
        stdstore.target(address(call)).sig("optionId()").checked_write(100);
        assertEq(call.optionId(), 100);
    }

    // function test_StorageOptionStruct() public {
    //     uint256 slot = stdstore
    //         .target(address(call))
    //         .sig(call.optionIdToOption.selector)
    //         .with_key(address(this))
    //         .depth(0)
    //         .find();
    //     assertEq(
    //         uint256(keccak256(abi.encode(address(this), address(this)))),
    //         slot
    //     );
    // }

    function test_WriteToOptionIdFuzz(uint96 _id) public {
        stdstore.target(address(call)).sig("optionId()").checked_write(_id);
        assertEq(call.optionId(), _id);
    }

    //Create a call option
    function testFail_writeCallOption() public {
        call.sellCall{value: 1 ether}(0, 1, 1);
    }

    function test_writeCallOption() public {
        call.sellCall{value: 1 ether}(1 ether, 1, 1);
    }

    function test_writeCallOptionFuzz(uint96 _strike, uint96 _premiumDue, uint96 _secondsToExpiry) public {
        _strike = 1 ether;
        call.sellCall{value: 1 ether}(_strike, _premiumDue, _secondsToExpiry);
    }

    function test_writeCallOptionId() public {
        uint256 id1 = call.sellCall{value: 1 ether}(1 ether, 1, 1);
        uint256 id2 = call.sellCall{value: 1 ether}(1 ether, 1, 1);
        assertEq(id1 + 1, id2);
    }

    function test_emitOpenOption() public {
        //check topic 0 & 1 (indexed), but not data
        vm.expectEmit(true, true, false, false);
        //the event expected
        emit CallOptionOpen(address(this), 1, 1, 1 ether);
        //emits the event
        call.sellCall{value: 1 ether}(1 ether, 1, 1);
    }

    function testFail_emitOpenOption() public {
        vm.expectEmit(true, true, false, false);
        emit CallOptionOpen(address(0x1), 1, 1, 1 ether);
        call.sellCall{value: 1 ether}(1 ether, 1, 1);
    }

    function testCannot_writeCallOptionWithWrongValue() public {
        vm.expectRevert(Unauthorized.selector);
        call.sellCall{value: 1 ether}(1 wei, 1 wei, 60);
    }

    //Buy a Call Option
    function test_buyCallOption() public {
        call.sellCall{value: 1 wei}(1 wei, 1 wei, 60);
        dai.approve(address(call), 1e8);
        call.buyCall(1);
    }

    function testFail_buyCallOption() public {
        call.sellCall{value: 1 wei}(1 wei, 1 wei, 60);
        dai.approve(address(call), 1e8);
        call.buyCall(0);
    }

    function test_emitBoughtOption() public {
        call.sellCall{value: 1 wei}(1 wei, 1, 1);
        dai.approve(address(call), 1e8);

        vm.expectEmit(true, false, false, false);
        emit CallOptionBought(address(this), 1);
        call.buyCall(1);
    }

    function testCannot_buyOptionWithWrongIdFuzz(uint96 _id) public {
        vm.assume(_id > 1);
        vm.expectRevert(Unauthorized.selector);
        call.buyCall(_id);
    }

    //TODO: Test chainlink price feed called in functions

    //Exercise a call option
    // function test_exerciseCallOption() public {
    //     call.writeCallOption{value: 1 wei}(1 wei, 1, 60);
    //     dai.approve(address(call), 1e18);
    //     call.buyCallOption(1);

    //     //change block.timestamp
    //     vm.warp(90);

    //     call.exerciseCallOption(1, 1e18);
    // }
}
