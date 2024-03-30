//IN PROGRESS...
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

///@notice An Everlasting Option: Are the same as perpetual futures, but for options.
///The trader gets exposure with no need to roll the position. There is No expiration.
///Everyday, traders who are long pay a "funding fee" to those who are short.
///Funding Fee is a little different from perps.
///Funding Fee = (mark price - payoff price)
///Mark price == current option market price. Payoff price == is the put pay off, so if strike>spot == value, if strike<spot, then payoff is 0 for put option.
///Example: Trader holds the $5000 strike ETH put, will always be able to sell ETH for $5000 as long as trader holds the put.
///Adavantage of this is trader only pays cost when entering or exiting position. No Rolling or worry about expiration.
///But will still pay funding fee q 24 hours (automatically).
///In general: If a perp gets more expensive than an underlying, longs will pay high funding fees.
///This leads to longs selling the perp, returning price to neutral.
contract EverlastingOptions {
    //storage
    IERC20 dai;

    enum Direction {
        Short,
        Long
    }

    struct Position {
        address user;
        uint256 strike;
        Direction direction;
    }

    uint256 positionId;
    uint256 priceCount;
    uint256 avgPrice;

    mapping(uint256 => Position) public idToPosition;

    //ERRORS
    error TransferFailed();

    //EVENTS
    event ReserveDeposit(address indexed user, uint256 value);

    constructor(address _daiAddr) {
        dai = IERC20(_daiAddr);
    }

    function depositShort(uint256 _daiAmt, uint256 _strike)
        public
        returns (bool)
    {
        bool deposit = dai.transferFrom(msg.sender, address(this), _daiAmt);
        if (!deposit) revert TransferFailed();

        ++positionId;

        idToPosition[positionId] = Position(
            msg.sender,
            _strike,
            Direction.Short
        );

        return true;
    }

    function withdrawShort() public {}

    function depositLong() public {}

    function withdrawLong() public {}

    function calcAvgPrice() public {
        ++priceCount;
        uint256 spot = getSpotPrice();
        uint256 diff = (spot - avgPrice) / priceCount;
        uint256 newAvgPrice = avgPrice + diff;
    }

    function getSpotPrice() public view returns (uint256) {
        //oracle
        uint256 spot;
        return spot;
    }

    function calcPayoff(uint256 _strike, uint256 _spot)
        public
        view
        returns (uint256)
    {
        _spot = getSpotPrice();
        uint256 payoff;

        if (_strike > _spot) {
            payoff = (_strike - _spot);
        } else {
            payoff = 0;
        }
        return payoff;
    }

    function calcFundingFee(uint256 _strike, uint256 _spot)
        public
        view
        returns (uint256)
    {
        uint256 payoff = calcPayoff(_strike, _spot);
        uint256 mark = _spot;

        uint256 fee = (mark - payoff);

        return fee;
    }

    function liquidations() public {}

    receive() external payable {
        emit ReserveDeposit(msg.sender, msg.value);
    }
}
