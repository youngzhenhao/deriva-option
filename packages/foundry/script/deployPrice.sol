//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {PriceFeedConsumer} from "../contracts/PriceFeedConsumer.sol";
import "./deployHelpers.sol";

contract PriceFeedConsumerScript is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        PriceFeedConsumer price =
            new PriceFeedConsumer(address(0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0));
        console.logString(
            string.concat(
                "PriceFeedConsumer deployed at: ", vm.toString(address(price))
            )
        );
        vm.stopBroadcast();


        exportDeployments();
    }

    function test() public {}
}
