//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {FT} from "../contracts/FT.sol";
import "./deployHelpers.sol";

contract FtScript is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        FT ft =
            new FT();
        console.logString(
            string.concat(
                "FT deployed at: ", vm.toString(address(ft))
            )
        );
        vm.stopBroadcast();


        exportDeployments();
    }

    function test() public {}
}
