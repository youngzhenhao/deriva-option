//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {MockV3Aggregator} from "../contracts/MockV3Aggregator.sol";
import "./deployHelpers.sol";

contract MockV3AggregatorScript is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        MockV3Aggregator mock =
            new MockV3Aggregator();
        console.logString(
            string.concat(
                "MockV3Aggregator deployed at: ", vm.toString(address(mock))
            )
        );
        vm.stopBroadcast();


        exportDeployments();
    }

    function test() public {}
}
