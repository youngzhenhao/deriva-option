// SPDX-License-Identifier: WTFPL
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {PriceFeedConsumer} from "../src/oracle/PriceFeedConsumer.sol";

contract PriceFeedConsumerScript is Script {
    address MOCKV3AGGREGATOR_ADDRESS = 0xF7d89cAE730994fEb722F9B657219C52F9304e87;

    function run() external {
        vm.startBroadcast();
        PriceFeedConsumer priceFeedConsumer = new PriceFeedConsumer(MOCKV3AGGREGATOR_ADDRESS);
        vm.stopBroadcast();
    }
}

// .\env.ps1
// forge script script/PriceFeedConsumer.s.sol:PriceFeedConsumerScript --rpc-url=$env:SEPOLIA_RPC_URL --private-keys=$env:PRIVATE_KEY --broadcast --verify -vvvv

/**
 * [⠒] Compiling...
 * [⠔] Compiling 2 files with 0.8.22
 * [⠒] Solc 0.8.22 finished in 2.26s
 * Compiler run successful with warnings:
 * Warning (2072): Unused local variable.
 *   --> script/MockV3Aggregator.s.sol:10:9:
 *    |
 * 10 |         MockV3Aggregator mockV3Aggregator = new MockV3Aggregator(18, 1e18);
 *    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 *
 * Warning (2072): Unused local variable.
 *   --> script/PriceFeedConsumer.s.sol:12:9:
 *    |
 * 12 |         PriceFeedConsumer priceFeedConsumer = new PriceFeedConsumer(MOCKV3AGGREGATOR_ADDRESS);
 *    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 *
 * Traces:
 *   [143982] PriceFeedConsumerScript::run()
 *     ├─ [0] VM::startBroadcast()
 *     │   └─ ← ()
 *     ├─ [106175] → new PriceFeedConsumer@0x4133320051906a707900f06857836f1368136dBd
 *     │   └─ ← 529 bytes of code
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
 *   [106175] → new PriceFeedConsumer@0x4133320051906a707900f06857836f1368136dBd
 *     └─ ← 529 bytes of code
 *
 *
 * ==========================
 *
 * Chain 11155111
 *
 * Estimated gas price: 3.211406868 gwei
 *
 * Estimated total gas used for script: 220062
 *
 * Estimated amount required: 0.000706708618185816 ETH
 *
 * ==========================
 * ##
 * Sending transactions [0 - 0].
 * ⠁ [00:00:00] [#####################################################################################################] 1/1 txes (0.0s)##
 * Waiting for receipts.
 * ⠉ [00:00:13] [#################################################################################################] 1/1 receipts (0.0s)
 * ##### sepolia
 * ✅  [Success]Hash: 0xd3dab9c19be285f7cf1be4282673f586e0c5337dcd06d5e7cb0b6eaf422dd3a6
 * Contract Address: 0x4133320051906a707900f06857836f1368136dBd
 * Block: 5581930
 * Paid: 0.000523212932787237 ETH (169323 gas * 3.090028719 gwei)
 *
 *
 *
 * ==========================
 *
 * ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
 * Total Paid: 0.000523212932787237 ETH (169323 gas * avg 3.090028719 gwei)
 * ##
 * Start verification for (1) contracts
 * Start verifying contract `0x4133320051906a707900f06857836f1368136dBd` deployed on sepolia
 *
 * Submitting verification for [src/oracle/PriceFeedConsumer.sol:PriceFeedConsumer] 0x4133320051906a707900f06857836f1368136dBd.        
 * Submitted contract for verification:
 *         Response: `OK`
 *         GUID: `itav5nibehfkujvsjmeavltuzqczqecwmbyk2hz9wlvdqntj4i`
 *         URL: https://sepolia.etherscan.io/address/0x4133320051906a707900f06857836f1368136dbd
 * Contract verification status:
 * Response: `NOTOK`
 * Details: `Pending in queue`
 * Contract verification status:
 * Response: `OK`
 * Details: `Pass - Verified`
 * Contract successfully verified
 * All (1) contracts were verified!
 *
 * Transactions saved to: C:/mySpace/deriva-option-dev/broadcast\PriceFeedConsumer.s.sol\11155111\run-latest.json
 *
 * Sensitive values saved to: C:/mySpace/deriva-option-dev/cache\PriceFeedConsumer.s.sol\11155111\run-latest.json
 */
