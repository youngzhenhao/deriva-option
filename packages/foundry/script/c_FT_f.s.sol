//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {c_FT_f} from "../contracts/c_FT_f.sol";
import "./c.Helpers.s.sol";

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
        c_FT_f ft =
            new c_FT_f();
        console.logString(
            string.concat(
                "c_FT_f deployed at: ", vm.toString(address(ft))
            )
        );
        vm.stopBroadcast();


        exportDeployments();
    }

    function test() public {}
}
