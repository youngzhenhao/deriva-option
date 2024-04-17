//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {c_DAI_f} from "../contracts/c_DAI_f.sol";
import "./c.Helpers.s.sol";

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
        c_DAI_f dai =
            new c_DAI_f();
        console.logString(
            string.concat(
                "c_DAI_f deployed at: ", vm.toString(address(dai))
            )
        );
        vm.stopBroadcast();


        exportDeployments();
    }

    function test() public {}
}
