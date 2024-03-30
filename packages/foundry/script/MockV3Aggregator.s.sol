// SPDX-License-Identifier: WTFPL
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../src/mocks/MockV3Aggregator.sol";

contract MockV3AggregatorScript is Script {
    function run() external {
        vm.startBroadcast();
        MockV3Aggregator mockV3Aggregator = new MockV3Aggregator(18, 1e18);
        vm.stopBroadcast();
    }
}

// .\env.ps1
// forge script script/MockV3Aggregator.s.sol:MockV3AggregatorScript --rpc-url=$env:SEPOLIA_RPC_URL --private-keys=$env:PRIVATE_KEY --broadcast --verify -vvvv

/**
 * [⠒] Compiling...
 * [⠊] Compiling 1 files with 0.8.22
 * [⠢] Solc 0.8.22 finished in 1.91s
 * Compiler run successful with warnings:
 * Warning (2072): Unused local variable.
 *   --> script/MockV3Aggregator.s.sol:10:9:
 *    |
 * 10 |         MockV3Aggregator mockV3Aggregator = new MockV3Aggregator(18, 1e18);
 *    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 *
 * Traces:
 *   [408205] MockV3AggregatorScript::run()
 *     ├─ [0] VM::startBroadcast()
 *     │   └─ ← ()
 *     ├─ [372455] → new MockV3Aggregator@0xF7d89cAE730994fEb722F9B657219C52F9304e87
 *     │   └─ ← 1083 bytes of code
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
 *   [372455] → new MockV3Aggregator@0xF7d89cAE730994fEb722F9B657219C52F9304e87
 *     └─ ← 1083 bytes of code
 *
 *
 * ==========================
 *
 * Chain 11155111
 *
 * Estimated gas price: 3.219697104 gwei
 *
 * Estimated total gas used for script: 580677
 *
 * Estimated amount required: 0.001869604055259408 ETH
 *
 * ==========================
 * ##
 * Sending transactions [0 - 0].
 * ⠁ [00:00:00] [####################################################################################################################] 1/1 txes (0.0s)##
 * Waiting for receipts.
 * ⠉ [00:00:13] [################################################################################################################] 1/1 receipts (0.0s)
 * ##### sepolia
 * ✅  [Success]Hash: 0xbe2d1efc159803de0abfc196b4cd09e8c6371f5a936882d923c98631697ed6cb
 * Contract Address: 0xF7d89cAE730994fEb722F9B657219C52F9304e87
 * Block: 5581895
 * Paid: 0.001388948324588935 ETH (446765 gas * 3.108901379 gwei)
 *
 *
 *
 * ==========================
 *
 * ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
 * Total Paid: 0.001388948324588935 ETH (446765 gas * avg 3.108901379 gwei)
 * ##
 * Start verification for (1) contracts
 * Start verifying contract `0xF7d89cAE730994fEb722F9B657219C52F9304e87` deployed on sepolia
 *
 * Submitting verification for [src/mocks/MockV3Aggregator.sol:MockV3Aggregator] 0xF7d89cAE730994fEb722F9B657219C52F9304e87.
 *
 * Submitting verification for [src/mocks/MockV3Aggregator.sol:MockV3Aggregator] 0xF7d89cAE730994fEb722F9B657219C52F9304e87.
 *
 * Submitting verification for [src/mocks/MockV3Aggregator.sol:MockV3Aggregator] 0xF7d89cAE730994fEb722F9B657219C52F9304e87.
 *
 * Submitting verification for [src/mocks/MockV3Aggregator.sol:MockV3Aggregator] 0xF7d89cAE730994fEb722F9B657219C52F9304e87.
 *
 * Submitting verification for [src/mocks/MockV3Aggregator.sol:MockV3Aggregator] 0xF7d89cAE730994fEb722F9B657219C52F9304e87.
 *
 * Submitting verification for [src/mocks/MockV3Aggregator.sol:MockV3Aggregator] 0xF7d89cAE730994fEb722F9B657219C52F9304e87.
 * Submitted contract for verification:
 *         Response: `OK`
 *         GUID: `3ulaq8uzygp9ug8tnhsgdu7rlgbhpl3dtys3uawtcfj42i312z`
 *         URL: https://sepolia.etherscan.io/address/0xf7d89cae730994feb722f9b657219c52f9304e87
 * Contract verification status:
 * Response: `NOTOK`
 * Details: `Pending in queue`
 * Contract verification status:
 * Response: `OK`
 * Details: `Pass - Verified`
 * Contract successfully verified
 * All (1) contracts were verified!
 *
 * Transactions saved to: C:/mySpace/deriva-option-dev/broadcast\MockV3Aggregator.s.sol\11155111\run-latest.json
 *
 * Sensitive values saved to: C:/mySpace/deriva-option-dev/cache\MockV3Aggregator.s.sol\11155111\run-latest.json
 */
