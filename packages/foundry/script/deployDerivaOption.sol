//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {DerivaOption} from "../contracts/DerivaOption.sol";
import "./deployHelpers.sol";

contract DerivaOptionScript is ScaffoldETHDeploy {
    error InvalidPrivateKey(string);

    function run() external {
        uint256 deployerPrivateKey = setupLocalhostEnv();
        if (deployerPrivateKey == 0) {
            revert InvalidPrivateKey(
                "You don't have a deployer account. Make sure you have set DEPLOYER_PRIVATE_KEY in .env or use `yarn generate` to generate a new random account"
            );
        }
        vm.startBroadcast(deployerPrivateKey);
        DerivaOption derivaOption =
            new DerivaOption(address(0x5FbDB2315678afecb367f032d93F642f64180aa3),
            address(0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9));
        console.logString(
            string.concat(
                "DerivaOption deployed at: ", vm.toString(address(derivaOption))
            )
        );
        vm.stopBroadcast();


        exportDeployments();
    }

    function test() public {}
}
