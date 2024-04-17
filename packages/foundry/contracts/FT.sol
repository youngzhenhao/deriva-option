// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract FT is ERC20, Ownable {

    constructor() ERC20("FT", "FT") Ownable(msg.sender) {
        address addrA = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        address addrB = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        address addrC = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
        address addrDeOp = 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0;
        _mint(addrA, 2*1000*1e18);
        _mint(addrB, 2*1000*1e18);
        _mint(addrC, 2*1000*1e18);
        _approve(addrA,addrB,1000*1e18);
        _approve(addrA,addrC,1000*1e18);
        _approve(addrB,addrA,1000*1e18);
        _approve(addrB,addrC,1000*1e18);
        _approve(addrC,addrA,1000*1e18);
        _approve(addrC,addrB,1000*1e18);
        _approve(addrA,addrDeOp,1000*1e18);
        _approve(addrB,addrDeOp,1000*1e18);
        _approve(addrC,addrDeOp,1000*1e18);
    }

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function approveOnlyOwner(address owner, address spender, uint256 value) external onlyOwner {
        _approve(owner, spender, value);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

}
