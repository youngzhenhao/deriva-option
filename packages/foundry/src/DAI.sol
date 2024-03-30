// SPDX-License-Identifier: WTFPL
pragma solidity ^0.8.20;

import {FT} from "./FT.sol";

contract DAI is FT {
    constructor() FT("DAI", "DAI") {
        _mint(msg.sender, 100 * 1e18);
    }
}
