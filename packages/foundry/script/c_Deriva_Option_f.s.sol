//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {c_Deriva_Option_f} from "../contracts/c_Deriva_Option_f.sol";
import "./c.Helpers.s.sol";

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
        c_Deriva_Option_f derivaOption = new c_Deriva_Option_f(
            0x5FbDB2315678afecb367f032d93F642f64180aa3
        );
        console.logString(
            string.concat(
                "c_Deriva_Option_f deployed at: ",
                vm.toString(address(derivaOption))
            )
        );
        vm.stopBroadcast();

        exportDeployments();
    }

    function test() public {}
}
