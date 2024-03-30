// SPDX-License-Identifier: WTFPL
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {DAI} from "../src/DAI.sol";

contract DAIScript is Script {
    function run() external {
        // uint256 deployerPrivateKey = vm.envUint("env:PRIVATE_KEY");
        // vm.startBroadcast(deployerPrivateKey);
        vm.startBroadcast();
        DAI dai = new DAI();
        vm.stopBroadcast();
    }
}

// .\env.ps1
// forge script script/DAI.s.sol:DAIScript --rpc-url=$env:SEPOLIA_RPC_URL --private-keys=$env:PRIVATE_KEY --broadcast --verify -vvvv

/**
 * [⠒] Compiling...
 * No files changed, compilation skipped
 * Traces:
 *   [695194] DAIScript::run()
 *     ├─ [0] VM::startBroadcast()
 *     │   └─ ← ()
 *     ├─ [659004] → new DAI@0xCCC6eBcEb5ed4D5dbD34EC6f31d7c73d3dF512b0
 *     │   ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: 0xdb1C2e5C52Cf17877ff7E182D64b3455D2f17ce7)
 *     │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: 0xdb1C2e5C52Cf17877ff7E182D64b3455D2f17ce7, value: 100000000000000000000 [1e20])
 *     │   └─ ← 2714 bytes of code
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
 *   [659004] → new DAI@0xCCC6eBcEb5ed4D5dbD34EC6f31d7c73d3dF512b0
 *     ├─ emit OwnershipTransferred(previousOwner: 0x0000000000000000000000000000000000000000, newOwner: 0xdb1C2e5C52Cf17877ff7E182D64b3455D2f17ce7)  
 *     ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: 0xdb1C2e5C52Cf17877ff7E182D64b3455D2f17ce7, value: 100000000000000000000
 *  [1e20])
 *     └─ ← 2714 bytes of code
 *
 *
 * ==========================
 *
 * Chain 11155111
 *
 * Estimated gas price: 3.23350419 gwei
 *
 * Estimated total gas used for script: 1002705
 *
 * Estimated amount required: 0.00324225081883395 ETH
 *
 * ==========================
 * ##
 * Sending transactions [0 - 0].
 * ⠁ [00:00:00] [####################################################################################################################] 1/1 txes (0.0s)##
 * Waiting for receipts.
 * ⠉ [00:00:13] [################################################################################################################] 1/1 receipts (0.0s)
 * ##### sepolia
 * ✅  [Success]Hash: 0xfd7f18b9ad5cf0e773e21d74b6c1e3af00476cf8d38bf118961c1b4b482705fe
 * Contract Address: 0xCCC6eBcEb5ed4D5dbD34EC6f31d7c73d3dF512b0
 * Block: 5581717
 * Paid: 0.002390992904293632 ETH (771552 gas * 3.098939416 gwei)
 *
 *
 *
 * ==========================
 *
 * ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
 * Total Paid: 0.002390992904293632 ETH (771552 gas * avg 3.098939416 gwei)
 * ##
 * Start verification for (1) contracts
 * Start verifying contract `0xCCC6eBcEb5ed4D5dbD34EC6f31d7c73d3dF512b0` deployed on sepolia
 *
 * Submitting verification for [src/DAI.sol:DAI] 0xCCC6eBcEb5ed4D5dbD34EC6f31d7c73d3dF512b0.
 *
 * Submitting verification for [src/DAI.sol:DAI] 0xCCC6eBcEb5ed4D5dbD34EC6f31d7c73d3dF512b0.
 *
 * Submitting verification for [src/DAI.sol:DAI] 0xCCC6eBcEb5ed4D5dbD34EC6f31d7c73d3dF512b0.
 * Submitted contract for verification:
 *         Response: `OK`
 *         GUID: `ekxe1qd8j3qfwcgxyumerjvqkktu21wrtruije5hzpsedifxtv`
 *         URL: https://sepolia.etherscan.io/address/0xccc6ebceb5ed4d5dbd34ec6f31d7c73d3df512b0
 * Contract verification status:
 * Response: `NOTOK`
 * Details: `Pending in queue`
 * Contract verification status:
 * Response: `OK`
 * Details: `Pass - Verified`
 * Contract successfully verified
 * All (1) contracts were verified!
 *
 * Transactions saved to: C:/mySpace/deriva-option-dev\broadcast\DAI.s.sol\11155111\run-latest.json
 *
 * Sensitive values saved to: C:/mySpace/deriva-option-dev/cache\DAI.s.sol\11155111\run-latest.json
 */
