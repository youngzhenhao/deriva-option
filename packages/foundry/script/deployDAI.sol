//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {DAI} from "../contracts/DAI.sol";
import "./deployHelpers.sol";

contract DaiScript is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        DAI dai =
            new DAI();
        console.logString(
            string.concat(
                "DAI deployed at: ", vm.toString(address(dai))
            )
        );
        vm.stopBroadcast();


        exportDeployments();
    }

    function test() public {}
}
