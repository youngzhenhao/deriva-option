// SPDX-License-Identifier: WTFPL
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {CallOptions} from "../src/CallOptions.sol";

contract CallOptionsScript is Script {
    address DAI_ADDRESS = 0xCCC6eBcEb5ed4D5dbD34EC6f31d7c73d3dF512b0;

    function run() external {
        vm.startBroadcast();
        CallOptions callOptions = new CallOptions(DAI_ADDRESS);
        vm.stopBroadcast();
    }
}

// .\env.ps1
// forge script script/CallOptions.s.sol:CallOptionsScript --rpc-url=$env:SEPOLIA_RPC_URL --private-keys=$env:PRIVATE_KEY --broadcast --verify -vvvv

/**
 * [⠒] Compiling...
 * [⠢] Compiling 3 files with 0.8.22
 * [⠆] Solc 0.8.22 finished in 3.12s
 * Compiler run successful with warnings:
 * Warning (2072): Unused local variable.
 *   --> script/CallOptions.s.sol:12:9:
 *    |
 * 12 |         CallOptions callOptions = new CallOptions(DAI_ADDRESS);
 *    |         ^^^^^^^^^^^^^^^^^^^^^^^
 *
 * Traces:
 *   [993210] CallOptionsScript::run()
 *     ├─ [0] VM::startBroadcast()
 *     │   └─ ← ()
 *     ├─ [954603] → new CallOptions@0x1dF79eb8A213522Ed06dEe8773d1A2AA08EC3A42
 *     │   └─ ← 4546 bytes of code
 *     ├─ [0] VM::stopBroadcast()
 *     │   └─ ← ()
 *     └─ ← ()
 *
 *
 * Script ran successfully.
 *
 * ## Setting up 1 EVM.
 * ==========================
 * Simulated On-chain Traces:
 *
 *   [954603] → new CallOptions@0x1dF79eb8A213522Ed06dEe8773d1A2AA08EC3A42
 *     └─ ← 4546 bytes of code
 *
 *
 * ==========================
 *
 * Chain 11155111
 *
 * Estimated gas price: 3.190961818 gwei
 *
 * Estimated total gas used for script: 1405756
 *
 * Estimated amount required: 0.004485713721424408 ETH
 *
 * ==========================
 * ##
 * Sending transactions [0 - 0].
 * ⠁ [00:00:01] [####################################################################################################################] 1/1 txes (0.0s)##
 * Waiting for receipts.
 * ⠉ [00:00:08] [################################################################################################################] 1/1 receipts (0.0s)
 * ##### sepolia
 * ✅  [Success]Hash: 0x5ccdb70a47c292b6c4fe934c31ca91430ee1485e0c0c4d498f5c6d96594a8270
 * Contract Address: 0x1dF79eb8A213522Ed06dEe8773d1A2AA08EC3A42
 * Block: 5581826
 * Paid: 0.003350959212631086 ETH (1081647 gas * 3.098015538 gwei)
 *
 *
 *
 * ==========================
 *
 * ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
 * Total Paid: 0.003350959212631086 ETH (1081647 gas * avg 3.098015538 gwei)
 * ##
 * Start verification for (1) contracts
 * Start verifying contract `0x1dF79eb8A213522Ed06dEe8773d1A2AA08EC3A42` deployed on sepolia
 *
 * Submitting verification for [src/CallOptions.sol:CallOptions] 0x1dF79eb8A213522Ed06dEe8773d1A2AA08EC3A42.
 * Submitted contract for verification:
 *         Response: `OK`
 *         GUID: `glmz4vusism5ycquhnxvxtmi4tkvhamfwy2vtukqfgg6jbkqec`
 *         URL: https://sepolia.etherscan.io/address/0x1df79eb8a213522ed06dee8773d1a2aa08ec3a42
 * Contract verification status:
 * Response: `NOTOK`
 * Details: `Pending in queue`
 * Contract verification status:
 * Response: `OK`
 * Details: `Pass - Verified`
 * Contract successfully verified
 * All (1) contracts were verified!
 *
 * Transactions saved to: C:/mySpace/deriva-option-dev/broadcast\CallOptions.s.sol\11155111\run-latest.json
 *
 * Sensitive values saved to: C:/mySpace/deriva-option-dev/cache\CallOptions.s.sol\11155111\run-latest.json
 */
