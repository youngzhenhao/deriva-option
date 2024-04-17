// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
pragma experimental ABIEncoderV2;

// contracts/SafeMath.sol

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(
        uint256 a,
        uint256 b
    ) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

// contracts/console.sol

library console {
    address constant CONSOLE_ADDRESS =
        address(0x000000000000000000636F6e736F6c652e6c6f67);

    function _sendLogPayload(bytes memory payload) private view {
        uint256 payloadLength = payload.length;
        address consoleAddress = CONSOLE_ADDRESS;
        assembly {
            let payloadStart := add(payload, 32)
            let r := staticcall(
                gas(),
                consoleAddress,
                payloadStart,
                payloadLength,
                0,
                0
            )
        }
    }

    function log() internal view {
        _sendLogPayload(abi.encodeWithSignature("log()"));
    }

    function logInt(int p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(int)", p0));
    }

    function logUint(uint p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint)", p0));
    }

    function logString(string memory p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
    }

    function logBool(bool p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool)", p0));
    }

    function logAddress(address p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address)", p0));
    }

    function logBytes(bytes memory p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes)", p0));
    }

    // function logByte(byte p0) internal view {
    // 	_sendLogPayload(abi.encodeWithSignature("log(byte)", p0));
    // }

    function logBytes1(bytes1 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes1)", p0));
    }

    function logBytes2(bytes2 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes2)", p0));
    }

    function logBytes3(bytes3 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes3)", p0));
    }

    function logBytes4(bytes4 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes4)", p0));
    }

    function logBytes5(bytes5 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes5)", p0));
    }

    function logBytes6(bytes6 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes6)", p0));
    }

    function logBytes7(bytes7 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes7)", p0));
    }

    function logBytes8(bytes8 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes8)", p0));
    }

    function logBytes9(bytes9 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes9)", p0));
    }

    function logBytes10(bytes10 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes10)", p0));
    }

    function logBytes11(bytes11 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes11)", p0));
    }

    function logBytes12(bytes12 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes12)", p0));
    }

    function logBytes13(bytes13 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes13)", p0));
    }

    function logBytes14(bytes14 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes14)", p0));
    }

    function logBytes15(bytes15 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes15)", p0));
    }

    function logBytes16(bytes16 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes16)", p0));
    }

    function logBytes17(bytes17 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes17)", p0));
    }

    function logBytes18(bytes18 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes18)", p0));
    }

    function logBytes19(bytes19 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes19)", p0));
    }

    function logBytes20(bytes20 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes20)", p0));
    }

    function logBytes21(bytes21 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes21)", p0));
    }

    function logBytes22(bytes22 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes22)", p0));
    }

    function logBytes23(bytes23 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes23)", p0));
    }

    function logBytes24(bytes24 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes24)", p0));
    }

    function logBytes25(bytes25 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes25)", p0));
    }

    function logBytes26(bytes26 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes26)", p0));
    }

    function logBytes27(bytes27 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes27)", p0));
    }

    function logBytes28(bytes28 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes28)", p0));
    }

    function logBytes29(bytes29 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes29)", p0));
    }

    function logBytes30(bytes30 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes30)", p0));
    }

    function logBytes31(bytes31 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes31)", p0));
    }

    function logBytes32(bytes32 p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bytes32)", p0));
    }

    function log(uint p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint)", p0));
    }

    function log(string memory p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string)", p0));
    }

    function log(bool p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool)", p0));
    }

    function log(address p0) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address)", p0));
    }

    function log(uint p0, uint p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,uint)", p0, p1));
    }

    function log(uint p0, string memory p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,string)", p0, p1));
    }

    function log(uint p0, bool p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,bool)", p0, p1));
    }

    function log(uint p0, address p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(uint,address)", p0, p1));
    }

    function log(string memory p0, uint p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,uint)", p0, p1));
    }

    function log(string memory p0, string memory p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,string)", p0, p1));
    }

    function log(string memory p0, bool p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,bool)", p0, p1));
    }

    function log(string memory p0, address p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(string,address)", p0, p1));
    }

    function log(bool p0, uint p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,uint)", p0, p1));
    }

    function log(bool p0, string memory p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,string)", p0, p1));
    }

    function log(bool p0, bool p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,bool)", p0, p1));
    }

    function log(bool p0, address p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(bool,address)", p0, p1));
    }

    function log(address p0, uint p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,uint)", p0, p1));
    }

    function log(address p0, string memory p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,string)", p0, p1));
    }

    function log(address p0, bool p1) internal view {
        _sendLogPayload(abi.encodeWithSignature("log(address,bool)", p0, p1));
    }

    function log(address p0, address p1) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,address)", p0, p1)
        );
    }

    function log(uint p0, uint p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,uint,uint)", p0, p1, p2)
        );
    }

    function log(uint p0, uint p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,uint,string)", p0, p1, p2)
        );
    }

    function log(uint p0, uint p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,uint,bool)", p0, p1, p2)
        );
    }

    function log(uint p0, uint p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,uint,address)", p0, p1, p2)
        );
    }

    function log(uint p0, string memory p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,string,uint)", p0, p1, p2)
        );
    }

    function log(uint p0, string memory p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,string,string)", p0, p1, p2)
        );
    }

    function log(uint p0, string memory p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,string,bool)", p0, p1, p2)
        );
    }

    function log(uint p0, string memory p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,string,address)", p0, p1, p2)
        );
    }

    function log(uint p0, bool p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,bool,uint)", p0, p1, p2)
        );
    }

    function log(uint p0, bool p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,bool,string)", p0, p1, p2)
        );
    }

    function log(uint p0, bool p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,bool,bool)", p0, p1, p2)
        );
    }

    function log(uint p0, bool p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,bool,address)", p0, p1, p2)
        );
    }

    function log(uint p0, address p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,address,uint)", p0, p1, p2)
        );
    }

    function log(uint p0, address p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,address,string)", p0, p1, p2)
        );
    }

    function log(uint p0, address p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,address,bool)", p0, p1, p2)
        );
    }

    function log(uint p0, address p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,address,address)", p0, p1, p2)
        );
    }

    function log(string memory p0, uint p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,uint,uint)", p0, p1, p2)
        );
    }

    function log(string memory p0, uint p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,uint,string)", p0, p1, p2)
        );
    }

    function log(string memory p0, uint p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,uint,bool)", p0, p1, p2)
        );
    }

    function log(string memory p0, uint p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,uint,address)", p0, p1, p2)
        );
    }

    function log(string memory p0, string memory p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,string,uint)", p0, p1, p2)
        );
    }

    function log(
        string memory p0,
        string memory p1,
        string memory p2
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,string,string)", p0, p1, p2)
        );
    }

    function log(string memory p0, string memory p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,string,bool)", p0, p1, p2)
        );
    }

    function log(string memory p0, string memory p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,string,address)", p0, p1, p2)
        );
    }

    function log(string memory p0, bool p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,bool,uint)", p0, p1, p2)
        );
    }

    function log(string memory p0, bool p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,bool,string)", p0, p1, p2)
        );
    }

    function log(string memory p0, bool p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,bool,bool)", p0, p1, p2)
        );
    }

    function log(string memory p0, bool p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,bool,address)", p0, p1, p2)
        );
    }

    function log(string memory p0, address p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,address,uint)", p0, p1, p2)
        );
    }

    function log(string memory p0, address p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,address,string)", p0, p1, p2)
        );
    }

    function log(string memory p0, address p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,address,bool)", p0, p1, p2)
        );
    }

    function log(string memory p0, address p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(string,address,address)", p0, p1, p2)
        );
    }

    function log(bool p0, uint p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,uint,uint)", p0, p1, p2)
        );
    }

    function log(bool p0, uint p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,uint,string)", p0, p1, p2)
        );
    }

    function log(bool p0, uint p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,uint,bool)", p0, p1, p2)
        );
    }

    function log(bool p0, uint p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,uint,address)", p0, p1, p2)
        );
    }

    function log(bool p0, string memory p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,string,uint)", p0, p1, p2)
        );
    }

    function log(bool p0, string memory p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,string,string)", p0, p1, p2)
        );
    }

    function log(bool p0, string memory p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,string,bool)", p0, p1, p2)
        );
    }

    function log(bool p0, string memory p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,string,address)", p0, p1, p2)
        );
    }

    function log(bool p0, bool p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,bool,uint)", p0, p1, p2)
        );
    }

    function log(bool p0, bool p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,bool,string)", p0, p1, p2)
        );
    }

    function log(bool p0, bool p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,bool,bool)", p0, p1, p2)
        );
    }

    function log(bool p0, bool p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,bool,address)", p0, p1, p2)
        );
    }

    function log(bool p0, address p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,address,uint)", p0, p1, p2)
        );
    }

    function log(bool p0, address p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,address,string)", p0, p1, p2)
        );
    }

    function log(bool p0, address p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,address,bool)", p0, p1, p2)
        );
    }

    function log(bool p0, address p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,address,address)", p0, p1, p2)
        );
    }

    function log(address p0, uint p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,uint,uint)", p0, p1, p2)
        );
    }

    function log(address p0, uint p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,uint,string)", p0, p1, p2)
        );
    }

    function log(address p0, uint p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,uint,bool)", p0, p1, p2)
        );
    }

    function log(address p0, uint p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,uint,address)", p0, p1, p2)
        );
    }

    function log(address p0, string memory p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,string,uint)", p0, p1, p2)
        );
    }

    function log(address p0, string memory p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,string,string)", p0, p1, p2)
        );
    }

    function log(address p0, string memory p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,string,bool)", p0, p1, p2)
        );
    }

    function log(address p0, string memory p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,string,address)", p0, p1, p2)
        );
    }

    function log(address p0, bool p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,bool,uint)", p0, p1, p2)
        );
    }

    function log(address p0, bool p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,bool,string)", p0, p1, p2)
        );
    }

    function log(address p0, bool p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,bool,bool)", p0, p1, p2)
        );
    }

    function log(address p0, bool p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,bool,address)", p0, p1, p2)
        );
    }

    function log(address p0, address p1, uint p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,address,uint)", p0, p1, p2)
        );
    }

    function log(address p0, address p1, string memory p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,address,string)", p0, p1, p2)
        );
    }

    function log(address p0, address p1, bool p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,address,bool)", p0, p1, p2)
        );
    }

    function log(address p0, address p1, address p2) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(address,address,address)", p0, p1, p2)
        );
    }

    function log(uint p0, uint p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,uint,uint,uint)", p0, p1, p2, p3)
        );
    }

    function log(uint p0, uint p1, uint p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, uint p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,uint,uint,bool)", p0, p1, p2, p3)
        );
    }

    function log(uint p0, uint p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, uint p1, string memory p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        uint p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, uint p1, string memory p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, uint p1, string memory p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, uint p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,uint,bool,uint)", p0, p1, p2, p3)
        );
    }

    function log(uint p0, uint p1, bool p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, uint p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,uint,bool,bool)", p0, p1, p2, p3)
        );
    }

    function log(uint p0, uint p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, uint p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, uint p1, address p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, uint p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, uint p1, address p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,uint,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, string memory p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        string memory p1,
        uint p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, string memory p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, string memory p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        string memory p1,
        string memory p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        string memory p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        string memory p1,
        string memory p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        string memory p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, string memory p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        string memory p1,
        bool p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, string memory p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, string memory p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, string memory p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        string memory p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, string memory p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        string memory p1,
        address p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,string,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,bool,uint,uint)", p0, p1, p2, p3)
        );
    }

    function log(uint p0, bool p1, uint p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,bool,uint,bool)", p0, p1, p2, p3)
        );
    }

    function log(uint p0, bool p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, string memory p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        bool p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, string memory p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, string memory p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,bool,bool,uint)", p0, p1, p2, p3)
        );
    }

    function log(uint p0, bool p1, bool p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(uint,bool,bool,bool)", p0, p1, p2, p3)
        );
    }

    function log(uint p0, bool p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, address p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, bool p1, address p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,bool,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, uint p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, string memory p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        address p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, string memory p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        address p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, bool p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        uint p0,
        address p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(uint p0, address p1, address p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(uint,address,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, uint p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        uint p1,
        uint p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, uint p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, uint p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        uint p1,
        string memory p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        uint p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        uint p1,
        string memory p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        uint p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, uint p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        uint p1,
        bool p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, uint p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, uint p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, uint p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        uint p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, uint p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        uint p1,
        address p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,uint,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        uint p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        uint p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        uint p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        uint p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        string memory p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        string memory p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        bool p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        bool p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        bool p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        bool p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        address p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        address p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        string memory p1,
        address p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,string,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, bool p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        bool p1,
        uint p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, bool p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, bool p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        bool p1,
        string memory p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        bool p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        bool p1,
        string memory p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        bool p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, bool p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        bool p1,
        bool p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, bool p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, bool p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, bool p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        bool p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, bool p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        bool p1,
        address p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,bool,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, address p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        uint p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, address p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        uint p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        string memory p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        string memory p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, address p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        bool p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(string memory p0, address p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        bool p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        address p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        address p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        string memory p0,
        address p1,
        address p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(string,address,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,uint,uint,uint)", p0, p1, p2, p3)
        );
    }

    function log(bool p0, uint p1, uint p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,uint,uint,bool)", p0, p1, p2, p3)
        );
    }

    function log(bool p0, uint p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, string memory p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        uint p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, string memory p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, string memory p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,uint,bool,uint)", p0, p1, p2, p3)
        );
    }

    function log(bool p0, uint p1, bool p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,uint,bool,bool)", p0, p1, p2, p3)
        );
    }

    function log(bool p0, uint p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, address p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, uint p1, address p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,uint,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, string memory p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        string memory p1,
        uint p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, string memory p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, string memory p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        string memory p1,
        string memory p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        string memory p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        string memory p1,
        string memory p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        string memory p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, string memory p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        string memory p1,
        bool p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, string memory p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, string memory p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, string memory p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        string memory p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, string memory p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        string memory p1,
        address p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,string,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,bool,uint,uint)", p0, p1, p2, p3)
        );
    }

    function log(bool p0, bool p1, uint p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,bool,uint,bool)", p0, p1, p2, p3)
        );
    }

    function log(bool p0, bool p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, string memory p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        bool p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, string memory p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, string memory p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,bool,bool,uint)", p0, p1, p2, p3)
        );
    }

    function log(bool p0, bool p1, bool p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature("log(bool,bool,bool,bool)", p0, p1, p2, p3)
        );
    }

    function log(bool p0, bool p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, address p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, bool p1, address p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,bool,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, uint p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, string memory p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        address p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, string memory p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        address p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, bool p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        bool p0,
        address p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(bool p0, address p1, address p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(bool,address,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, uint p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, string memory p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        uint p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, string memory p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        uint p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, bool p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        uint p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, uint p1, address p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,uint,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, string memory p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        uint p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, string memory p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        uint p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        string memory p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        string memory p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, string memory p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        bool p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, string memory p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        bool p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        address p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        address p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        string memory p1,
        address p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,string,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, uint p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, string memory p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        bool p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, string memory p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        bool p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, bool p2, string memory p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        bool p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, bool p1, address p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,bool,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, address p1, uint p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,uint,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        address p1,
        uint p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,uint,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, address p1, uint p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,uint,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, address p1, uint p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,uint,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        address p1,
        string memory p2,
        uint p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,string,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        address p1,
        string memory p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,string,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        address p1,
        string memory p2,
        bool p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,string,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        address p1,
        string memory p2,
        address p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,string,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, address p1, bool p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,bool,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        address p1,
        bool p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,bool,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, address p1, bool p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,bool,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, address p1, bool p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,bool,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, address p1, address p2, uint p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,address,uint)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(
        address p0,
        address p1,
        address p2,
        string memory p3
    ) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,address,string)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, address p1, address p2, bool p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,address,bool)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }

    function log(address p0, address p1, address p2, address p3) internal view {
        _sendLogPayload(
            abi.encodeWithSignature(
                "log(address,address,address,address)",
                p0,
                p1,
                p2,
                p3
            )
        );
    }
}

// contracts/token/ERC20/IERC20.sol

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);
}

// contracts/token/ERC20/extensions/IERC20Permit.sol

/**
 * @dev Interface of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on {IERC20-approve}, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 *
 * ==== Security Considerations
 *
 * There are two important considerations concerning the use of `permit`. The first is that a valid permit signature
 * expresses an allowance, and it should not be assumed to convey additional meaning. In particular, it should not be
 * considered as an intention to spend the allowance in any specific way. The second is that because permits have
 * built-in replay protection and can be submitted by anyone, they can be frontrun. A protocol that uses permits should
 * take this into consideration and allow a `permit` call to fail. Combining these two aspects, a pattern that may be
 * generally recommended is:
 *
 * ```solidity
 * function doThingWithPermit(..., uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public {
 *     try token.permit(msg.sender, address(this), value, deadline, v, r, s) {} catch {}
 *     doThing(..., value);
 * }
 *
 * function doThing(..., uint256 value) public {
 *     token.safeTransferFrom(msg.sender, address(this), value);
 *     ...
 * }
 * ```
 *
 * Observe that: 1) `msg.sender` is used as the owner, leaving no ambiguity as to the signer intent, and 2) the use of
 * `try/catch` allows the permit to fail and makes the code tolerant to frontrunning. (See also
 * {SafeERC20-safeTransferFrom}).
 *
 * Additionally, note that smart contract wallets (such as Argent or Safe) are not able to produce permit signatures, so
 * contracts should have entry points that don't rely on permit.
 */
interface IERC20Permit {
    /**
     * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
     * given ``owner``'s signed approval.
     *
     * IMPORTANT: The same issues {IERC20-approve} has related to transaction
     * ordering also apply here.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `deadline` must be a timestamp in the future.
     * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
     * over the EIP712-formatted function arguments.
     * - the signature must use ``owner``'s current nonce (see {nonces}).
     *
     * For more information on the signature format, see the
     * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
     * section].
     *
     * CAUTION: See Security Considerations above.
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be
     * included whenever a signature is generated for {permit}.
     *
     * Every successful call to {permit} increases ``owner``'s nonce by one. This
     * prevents a signature from being used multiple times.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}

// contracts/utils/Address.sol

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev The ETH balance of the account is not enough to perform the operation.
     */
    error AddressInsufficientBalance(address account);

    /**
     * @dev There's no code at `target` (it is not a contract).
     */
    error AddressEmptyCode(address target);

    /**
     * @dev A call to an address target failed. The target may have reverted.
     */
    error FailedInnerCall();

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://consensys.net/diligence/blog/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.8.20/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        if (address(this).balance < amount) {
            revert AddressInsufficientBalance(address(this));
        }

        (bool success, ) = recipient.call{value: amount}("");
        if (!success) {
            revert FailedInnerCall();
        }
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason or custom error, it is bubbled
     * up by this function (like regular Solidity function calls). However, if
     * the call reverted with no returned reason, this function reverts with a
     * {FailedInnerCall} error.
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     */
    function functionCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        if (address(this).balance < value) {
            revert AddressInsufficientBalance(address(this));
        }
        (bool success, bytes memory returndata) = target.call{value: value}(
            data
        );
        return verifyCallResultFromTarget(target, success, returndata);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     */
    function functionStaticCall(
        address target,
        bytes memory data
    ) internal view returns (bytes memory) {
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResultFromTarget(target, success, returndata);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     */
    function functionDelegateCall(
        address target,
        bytes memory data
    ) internal returns (bytes memory) {
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResultFromTarget(target, success, returndata);
    }

    /**
     * @dev Tool to verify that a low level call to smart-contract was successful, and reverts if the target
     * was not a contract or bubbling up the revert reason (falling back to {FailedInnerCall}) in case of an
     * unsuccessful call.
     */
    function verifyCallResultFromTarget(
        address target,
        bool success,
        bytes memory returndata
    ) internal view returns (bytes memory) {
        if (!success) {
            _revert(returndata);
        } else {
            // only check if target is a contract if the call was successful and the return data is empty
            // otherwise we already know that it was a contract
            if (returndata.length == 0 && target.code.length == 0) {
                revert AddressEmptyCode(target);
            }
            return returndata;
        }
    }

    /**
     * @dev Tool to verify that a low level call was successful, and reverts if it wasn't, either by bubbling the
     * revert reason or with a default {FailedInnerCall} error.
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata
    ) internal pure returns (bytes memory) {
        if (!success) {
            _revert(returndata);
        } else {
            return returndata;
        }
    }

    /**
     * @dev Reverts with returndata if present. Otherwise reverts with {FailedInnerCall}.
     */
    function _revert(bytes memory returndata) private pure {
        // Look for revert reason and bubble it up if present
        if (returndata.length > 0) {
            // The easiest way to bubble the revert reason is using memory via assembly
            /// @solidity memory-safe-assembly
            assembly {
                let returndata_size := mload(returndata)
                revert(add(32, returndata), returndata_size)
            }
        } else {
            revert FailedInnerCall();
        }
    }
}

// contracts/utils/ReentrancyGuard.sol

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant NOT_ENTERED = 1;
    uint256 private constant ENTERED = 2;

    uint256 private _status;

    /**
     * @dev Unauthorized reentrant call.
     */
    error ReentrancyGuardReentrantCall();

    constructor() {
        _status = NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function _nonReentrantBefore() private {
        // On the first call to nonReentrant, _status will be NOT_ENTERED
        if (_status == ENTERED) {
            revert ReentrancyGuardReentrantCall();
        }

        // Any calls to nonReentrant after this point will fail
        _status = ENTERED;
    }

    function _nonReentrantAfter() private {
        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = NOT_ENTERED;
    }

    /**
     * @dev Returns true if the reentrancy guard is currently set to "entered", which indicates there is a
     * `nonReentrant` function in the call stack.
     */
    function _reentrancyGuardEntered() internal view returns (bool) {
        return _status == ENTERED;
    }
}

// contracts/token/ERC20/utils/SafeERC20.sol

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    /**
     * @dev An operation with an ERC20 token failed.
     */
    error SafeERC20FailedOperation(address token);

    /**
     * @dev Indicates a failed `decreaseAllowance` request.
     */
    error SafeERC20FailedDecreaseAllowance(
        address spender,
        uint256 currentAllowance,
        uint256 requestedDecrease
    );

    /**
     * @dev Transfer `value` amount of `token` from the calling contract to `to`. If `token` returns no value,
     * non-reverting calls are assumed to be successful.
     */
    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeCall(token.transfer, (to, value)));
    }

    /**
     * @dev Transfer `value` amount of `token` from `from` to `to`, spending the approval given by `from` to the
     * calling contract. If `token` returns no value, non-reverting calls are assumed to be successful.
     */
    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeCall(token.transferFrom, (from, to, value))
        );
    }

    /**
     * @dev Increase the calling contract's allowance toward `spender` by `value`. If `token` returns no value,
     * non-reverting calls are assumed to be successful.
     */
    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 oldAllowance = token.allowance(address(this), spender);
        forceApprove(token, spender, oldAllowance + value);
    }

    /**
     * @dev Decrease the calling contract's allowance toward `spender` by `requestedDecrease`. If `token` returns no
     * value, non-reverting calls are assumed to be successful.
     */
    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 requestedDecrease
    ) internal {
        unchecked {
            uint256 currentAllowance = token.allowance(address(this), spender);
            if (currentAllowance < requestedDecrease) {
                revert SafeERC20FailedDecreaseAllowance(
                    spender,
                    currentAllowance,
                    requestedDecrease
                );
            }
            forceApprove(token, spender, currentAllowance - requestedDecrease);
        }
    }

    /**
     * @dev Set the calling contract's allowance toward `spender` to `value`. If `token` returns no value,
     * non-reverting calls are assumed to be successful. Meant to be used with tokens that require the approval
     * to be set to zero before setting it to a non-zero value, such as USDT.
     */
    function forceApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        bytes memory approvalCall = abi.encodeCall(
            token.approve,
            (spender, value)
        );

        if (!_callOptionalReturnBool(token, approvalCall)) {
            _callOptionalReturn(
                token,
                abi.encodeCall(token.approve, (spender, 0))
            );
            _callOptionalReturn(token, approvalCall);
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address-functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data);
        if (returndata.length != 0 && !abi.decode(returndata, (bool))) {
            revert SafeERC20FailedOperation(address(token));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     *
     * This is a variant of {_callOptionalReturn} that silents catches all reverts and returns a bool instead.
     */
    function _callOptionalReturnBool(
        IERC20 token,
        bytes memory data
    ) private returns (bool) {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We cannot use {Address-functionCall} here since this should return false
        // and not revert is the subcall reverts.

        (bool success, bytes memory returndata) = address(token).call(data);
        return
            success &&
            (returndata.length == 0 || abi.decode(returndata, (bool))) &&
            address(token).code.length > 0;
    }
}

// contracts/Option.sol

// @note: Deriva-Option's Contract

/**
 * @notice This contract is not audited and should not be used in a production environment.
 * @dev ! To compile this contract, you need to config "viaIR = true" in foundry.toml
 *      or config '{"settings": {"viaIR": true}}' in remix's compiler_config.json
 *      to avoid a stack too deep error.
 */

contract c_Deriva_Option_f is ReentrancyGuard {
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
