// SPDX-License-Identifier: WTFPL
pragma solidity ^0.8.20;

import {FT} from "./FT.sol";

contract TokenA is FT {
   constructor() FT ("TokenA" , "TokenA") {
         // _mint(msg.sender, 100 * 1000 * 1000 * 10**18);
      //   _mint(msg.sender, 1e18);
      //   approve(msg.sender, 1e18);
   }
}
