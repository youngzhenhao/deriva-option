import { GenericContractsDeclaration } from "~~/utils/scaffold-eth/contract";

/**
 * @example
 * const externalContracts = {
 *   1: {
 *     DAI: {
 *       address: "0x...",
 *       abi: [...],
 *     },
 *   },
 * } as const;
 */
const externalContracts = {
  31337: {
    DAI: {
      address: "0x5fbdb2315678afecb367f032d93f642f64180aa3",
      abi: [
        {
          type: "constructor",
          inputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "allowance",
          inputs: [
            {
              name: "owner",
              type: "address",
              internalType: "address",
            },
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
          ],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "approve",
          inputs: [
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "approveOnlyOwner",
          inputs: [
            {
              name: "owner",
              type: "address",
              internalType: "address",
            },
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "balanceOf",
          inputs: [
            {
              name: "account",
              type: "address",
              internalType: "address",
            },
          ],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "burn",
          inputs: [
            {
              name: "amount",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "decimals",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "uint8",
              internalType: "uint8",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "mint",
          inputs: [
            {
              name: "account",
              type: "address",
              internalType: "address",
            },
            {
              name: "amount",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "name",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "string",
              internalType: "string",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "owner",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "address",
              internalType: "address",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "renounceOwnership",
          inputs: [],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "symbol",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "string",
              internalType: "string",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "totalSupply",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "transfer",
          inputs: [
            {
              name: "to",
              type: "address",
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "transferFrom",
          inputs: [
            {
              name: "from",
              type: "address",
              internalType: "address",
            },
            {
              name: "to",
              type: "address",
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "transferOwnership",
          inputs: [
            {
              name: "newOwner",
              type: "address",
              internalType: "address",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "event",
          name: "Approval",
          inputs: [
            {
              name: "owner",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "spender",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "OwnershipTransferred",
          inputs: [
            {
              name: "previousOwner",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "newOwner",
              type: "address",
              indexed: true,
              internalType: "address",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "Transfer",
          inputs: [
            {
              name: "from",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "to",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "error",
          name: "ERC20InsufficientAllowance",
          inputs: [
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
            {
              name: "allowance",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "needed",
              type: "uint256",
              internalType: "uint256",
            },
          ],
        },
        {
          type: "error",
          name: "ERC20InsufficientBalance",
          inputs: [
            {
              name: "sender",
              type: "address",
              internalType: "address",
            },
            {
              name: "balance",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "needed",
              type: "uint256",
              internalType: "uint256",
            },
          ],
        },
        {
          type: "error",
          name: "ERC20InvalidApprover",
          inputs: [
            {
              name: "approver",
              type: "address",
              internalType: "address",
            },
          ],
        },
        {
          type: "error",
          name: "ERC20InvalidReceiver",
          inputs: [
            {
              name: "receiver",
              type: "address",
              internalType: "address",
            },
          ],
        },
        {
          type: "error",
          name: "ERC20InvalidSender",
          inputs: [
            {
              name: "sender",
              type: "address",
              internalType: "address",
            },
          ],
        },
        {
          type: "error",
          name: "ERC20InvalidSpender",
          inputs: [
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
          ],
        },
        {
          type: "error",
          name: "OwnableInvalidOwner",
          inputs: [
            {
              name: "owner",
              type: "address",
              internalType: "address",
            },
          ],
        },
        {
          type: "error",
          name: "OwnableUnauthorizedAccount",
          inputs: [
            {
              name: "account",
              type: "address",
              internalType: "address",
            },
          ],
        },
      ],
      inheritedFunctions: {
        allowance: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        approve: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        balanceOf: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        decimals: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        name: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        symbol: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        totalSupply: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        transfer: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        transferFrom: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        owner: "lib/openzeppelin-contracts/contracts/access/Ownable.sol",
        renounceOwnership: "lib/openzeppelin-contracts/contracts/access/Ownable.sol",
        transferOwnership: "lib/openzeppelin-contracts/contracts/access/Ownable.sol",
      },
    },
    FT: {
      address: "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512",
      abi: [
        {
          type: "constructor",
          inputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "allowance",
          inputs: [
            {
              name: "owner",
              type: "address",
              internalType: "address",
            },
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
          ],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "approve",
          inputs: [
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "approveOnlyOwner",
          inputs: [
            {
              name: "owner",
              type: "address",
              internalType: "address",
            },
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "balanceOf",
          inputs: [
            {
              name: "account",
              type: "address",
              internalType: "address",
            },
          ],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "burn",
          inputs: [
            {
              name: "amount",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "decimals",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "uint8",
              internalType: "uint8",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "mint",
          inputs: [
            {
              name: "account",
              type: "address",
              internalType: "address",
            },
            {
              name: "amount",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "name",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "string",
              internalType: "string",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "owner",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "address",
              internalType: "address",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "renounceOwnership",
          inputs: [],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "symbol",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "string",
              internalType: "string",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "totalSupply",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "transfer",
          inputs: [
            {
              name: "to",
              type: "address",
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "transferFrom",
          inputs: [
            {
              name: "from",
              type: "address",
              internalType: "address",
            },
            {
              name: "to",
              type: "address",
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "transferOwnership",
          inputs: [
            {
              name: "newOwner",
              type: "address",
              internalType: "address",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "event",
          name: "Approval",
          inputs: [
            {
              name: "owner",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "spender",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "OwnershipTransferred",
          inputs: [
            {
              name: "previousOwner",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "newOwner",
              type: "address",
              indexed: true,
              internalType: "address",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "Transfer",
          inputs: [
            {
              name: "from",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "to",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "error",
          name: "ERC20InsufficientAllowance",
          inputs: [
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
            {
              name: "allowance",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "needed",
              type: "uint256",
              internalType: "uint256",
            },
          ],
        },
        {
          type: "error",
          name: "ERC20InsufficientBalance",
          inputs: [
            {
              name: "sender",
              type: "address",
              internalType: "address",
            },
            {
              name: "balance",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "needed",
              type: "uint256",
              internalType: "uint256",
            },
          ],
        },
        {
          type: "error",
          name: "ERC20InvalidApprover",
          inputs: [
            {
              name: "approver",
              type: "address",
              internalType: "address",
            },
          ],
        },
        {
          type: "error",
          name: "ERC20InvalidReceiver",
          inputs: [
            {
              name: "receiver",
              type: "address",
              internalType: "address",
            },
          ],
        },
        {
          type: "error",
          name: "ERC20InvalidSender",
          inputs: [
            {
              name: "sender",
              type: "address",
              internalType: "address",
            },
          ],
        },
        {
          type: "error",
          name: "ERC20InvalidSpender",
          inputs: [
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
          ],
        },
        {
          type: "error",
          name: "OwnableInvalidOwner",
          inputs: [
            {
              name: "owner",
              type: "address",
              internalType: "address",
            },
          ],
        },
        {
          type: "error",
          name: "OwnableUnauthorizedAccount",
          inputs: [
            {
              name: "account",
              type: "address",
              internalType: "address",
            },
          ],
        },
      ],
      inheritedFunctions: {
        allowance: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        approve: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        balanceOf: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        decimals: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        name: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        symbol: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        totalSupply: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        transfer: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        transferFrom: "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol",
        owner: "lib/openzeppelin-contracts/contracts/access/Ownable.sol",
        renounceOwnership: "lib/openzeppelin-contracts/contracts/access/Ownable.sol",
        transferOwnership: "lib/openzeppelin-contracts/contracts/access/Ownable.sol",
      },
    },
    MockV3Aggregator: {
      address: "0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0",
      abi: [
        {
          type: "constructor",
          inputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "decimals",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "uint8",
              internalType: "uint8",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "description",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "string",
              internalType: "string",
            },
          ],
          stateMutability: "pure",
        },
        {
          type: "function",
          name: "getAnswer",
          inputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "int256",
              internalType: "int256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "getRoundData",
          inputs: [
            {
              name: "_roundId",
              type: "uint80",
              internalType: "uint80",
            },
          ],
          outputs: [
            {
              name: "roundId",
              type: "uint80",
              internalType: "uint80",
            },
            {
              name: "answer",
              type: "int256",
              internalType: "int256",
            },
            {
              name: "startedAt",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "updatedAt",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "answeredInRound",
              type: "uint80",
              internalType: "uint80",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "getTimestamp",
          inputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "latestAnswer",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "int256",
              internalType: "int256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "latestRound",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "latestRoundData",
          inputs: [],
          outputs: [
            {
              name: "roundId",
              type: "uint80",
              internalType: "uint80",
            },
            {
              name: "answer",
              type: "int256",
              internalType: "int256",
            },
            {
              name: "startedAt",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "updatedAt",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "answeredInRound",
              type: "uint80",
              internalType: "uint80",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "latestTimestamp",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "updateAnswer",
          inputs: [
            {
              name: "_answer",
              type: "int256",
              internalType: "int256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "updateRoundData",
          inputs: [
            {
              name: "_roundId",
              type: "uint80",
              internalType: "uint80",
            },
            {
              name: "_answer",
              type: "int256",
              internalType: "int256",
            },
            {
              name: "_timestamp",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "_startedAt",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "version",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
      ],
      inheritedFunctions: {},
    },
    PriceFeedConsumer: {
      address: "0xcf7ed3acca5a467e9e704c703e8d87f634fb0fc9",
      abi: [
        {
          type: "constructor",
          inputs: [
            {
              name: "_priceAggr",
              type: "address",
              internalType: "address",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "getPriceFeed",
          inputs: [
            {
              name: "_amount",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
      ],
      inheritedFunctions: {},
    },
    DerivaOption: {
      address: "0xdc64a140aa3e981100a9beca4e685f962f0cf6c9",
      abi: [
        {
          type: "constructor",
          inputs: [
            {
              name: "_daiAddr",
              type: "address",
              internalType: "address",
            },
            {
              name: "_priceFeedAddr",
              type: "address",
              internalType: "address",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "receive",
          stateMutability: "payable",
        },
        {
          type: "function",
          name: "approval",
          inputs: [
            {
              name: "owner",
              type: "address",
              internalType: "address",
            },
            {
              name: "designee",
              type: "address",
              internalType: "address",
            },
            {
              name: "purchaseId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "approvalAmount",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "approve",
          inputs: [
            {
              name: "designee",
              type: "address",
              internalType: "address",
            },
            {
              name: "amount",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "purchaseId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "buyOption_ETH",
          inputs: [
            {
              name: "_optionId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "buyOptionByExactPremiumAndExpiry",
          inputs: [
            {
              name: "buyer",
              type: "address",
              internalType: "address",
            },
            {
              name: "seller",
              type: "address",
              internalType: "address",
            },
            {
              name: "token",
              type: "address",
              internalType: "address",
            },
            {
              name: "isCallOption",
              type: "bool",
              internalType: "bool",
            },
            {
              name: "strikePrice",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "premium",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "expiry",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "amountPurchasing",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "purchaseResult",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "buyOptionByID",
          inputs: [
            {
              name: "buyer",
              type: "address",
              internalType: "address",
            },
            {
              name: "offerId",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "amountPurchasing",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "purchaseResult",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "cancelOptionOffer",
          inputs: [
            {
              name: "offerId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "cancelResult",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "exerciseOption",
          inputs: [
            {
              name: "purchaseId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "exerciseResult",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "exerciseOption_ETH",
          inputs: [
            {
              name: "_optionId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "payable",
        },
        {
          type: "function",
          name: "exerciseOptions",
          inputs: [
            {
              name: "purchaseIds",
              type: "uint256[]",
              internalType: "uint256[]",
            },
          ],
          outputs: [
            {
              name: "exerciseResult",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "getBlockNumber",
          inputs: [],
          outputs: [
            {
              name: "blockNumber",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "getBlockTimestamp",
          inputs: [],
          outputs: [
            {
              name: "blockTimestamp",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "getDaiToken",
          inputs: [],
          outputs: [
            {
              name: "dai",
              type: "address",
              internalType: "address",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "getLastOrderId",
          inputs: [],
          outputs: [
            {
              name: "_lastOrderId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "getLastPurchaseId",
          inputs: [],
          outputs: [
            {
              name: "_lastPurchaseId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "isOptionBuyable",
          inputs: [
            {
              name: "seller",
              type: "address",
              internalType: "address",
            },
            {
              name: "token",
              type: "address",
              internalType: "address",
            },
            {
              name: "isCallOption",
              type: "bool",
              internalType: "bool",
            },
            {
              name: "strikePrice",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "premium",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "expiry",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "amountPurchasing",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "isBuyable",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "lastOptionId_ETH",
          inputs: [],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "optionExpiresWorthless_ETH",
          inputs: [
            {
              name: "_optionId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "optionIdToOption_ETH",
          inputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "writer",
              type: "address",
              internalType: "address",
            },
            {
              name: "buyer",
              type: "address",
              internalType: "address",
            },
            {
              name: "strike",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "premiumDue",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "amount",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "expiration",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "collateral",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "optionState",
              type: "uint8",
              internalType: "enum DerivaOption.OptionState_ETH",
            },
            {
              name: "isCallOption",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "optionOffers",
          inputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "seller",
              type: "address",
              internalType: "address",
            },
            {
              name: "token",
              type: "address",
              internalType: "address",
            },
            {
              name: "isCallOption",
              type: "bool",
              internalType: "bool",
            },
            {
              name: "strikePrice",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "premium",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "expiry",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "amountUnderlyingToken",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "offeredTimestamp",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "isStillValid",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "optionPurchases",
          inputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "buyer",
              type: "address",
              internalType: "address",
            },
            {
              name: "seller",
              type: "address",
              internalType: "address",
            },
            {
              name: "token",
              type: "address",
              internalType: "address",
            },
            {
              name: "isCallOption",
              type: "bool",
              internalType: "bool",
            },
            {
              name: "strikePrice",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "premium",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "expiry",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "amountUnderlyingToken",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "offerId",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "purchasedTimestamp",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "exercised",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "queryAllowances",
          inputs: [
            {
              name: "account",
              type: "address",
              internalType: "address",
            },
            {
              name: "spender",
              type: "address",
              internalType: "address",
            },
          ],
          outputs: [
            {
              name: "allowance",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "queryOrderbook",
          inputs: [
            {
              name: "seller",
              type: "address",
              internalType: "address",
            },
            {
              name: "token",
              type: "address",
              internalType: "address",
            },
            {
              name: "isCallOption",
              type: "bool",
              internalType: "bool",
            },
            {
              name: "strikePrice",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "premium",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "expiry",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "_orderbook",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "queryPositions",
          inputs: [
            {
              name: "buyer",
              type: "address",
              internalType: "address",
            },
            {
              name: "token",
              type: "address",
              internalType: "address",
            },
            {
              name: "isCallOption",
              type: "bool",
              internalType: "bool",
            },
            {
              name: "strikePrice",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "expiry",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "position",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "queryTokenActivated",
          inputs: [
            {
              name: "token",
              type: "address",
              internalType: "address",
            },
          ],
          outputs: [
            {
              name: "isTokenActivated",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "retrieveExpiredFunds_ETH",
          inputs: [
            {
              name: "_optionId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "sellOption_ETH",
          inputs: [
            {
              name: "_strike",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "_premiumDue",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "_amount",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "_secondsToExpiry",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "_isCallOption",
              type: "bool",
              internalType: "bool",
            },
          ],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "payable",
        },
        {
          type: "function",
          name: "sellOption",
          inputs: [
            {
              name: "seller",
              type: "address",
              internalType: "address",
            },
            {
              name: "token",
              type: "address",
              internalType: "address",
            },
            {
              name: "isCallOption",
              type: "bool",
              internalType: "bool",
            },
            {
              name: "strikePrice",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "_premiumPrice",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "_expirySeconds",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "amountUnderlyingToken",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "orderIdentifier",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "tradersPosition_ETH",
          inputs: [
            {
              name: "",
              type: "address",
              internalType: "address",
            },
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          stateMutability: "view",
        },
        {
          type: "function",
          name: "transfer",
          inputs: [
            {
              name: "recipient",
              type: "address",
              internalType: "address",
            },
            {
              name: "amount",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "purchaseId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "function",
          name: "transferFrom",
          inputs: [
            {
              name: "from",
              type: "address",
              internalType: "address",
            },
            {
              name: "recipient",
              type: "address",
              internalType: "address",
            },
            {
              name: "amount",
              type: "uint256",
              internalType: "uint256",
            },
            {
              name: "purchaseId",
              type: "uint256",
              internalType: "uint256",
            },
          ],
          outputs: [
            {
              name: "",
              type: "bool",
              internalType: "bool",
            },
          ],
          stateMutability: "nonpayable",
        },
        {
          type: "event",
          name: "Approval",
          inputs: [
            {
              name: "owner",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "spender",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "purchaseId",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "FundsRetrieved_ETH",
          inputs: [
            {
              name: "writer",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "id",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "value",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "OptionBought_ETH",
          inputs: [
            {
              name: "buyer",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "id",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "OptionExercise",
          inputs: [
            {
              name: "optionId",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "exerciseCost",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "timestamp",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "OptionExercised_ETH",
          inputs: [
            {
              name: "buyer",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "id",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "OptionExpiresWorthless_ETH",
          inputs: [
            {
              name: "buyer",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "Id",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "OptionOffer",
          inputs: [
            {
              name: "seller",
              type: "address",
              indexed: false,
              internalType: "address",
            },
            {
              name: "token",
              type: "address",
              indexed: false,
              internalType: "address",
            },
            {
              name: "isCallOption",
              type: "bool",
              indexed: false,
              internalType: "bool",
            },
            {
              name: "strikePrice",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "premium",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "expiry",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "amountSelling",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "orderId",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "OptionOpen_ETH",
          inputs: [
            {
              name: "writer",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "id",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "expiration",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "value",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "OptionPurchase",
          inputs: [
            {
              name: "buyer",
              type: "address",
              indexed: false,
              internalType: "address",
            },
            {
              name: "seller",
              type: "address",
              indexed: false,
              internalType: "address",
            },
            {
              name: "token",
              type: "address",
              indexed: false,
              internalType: "address",
            },
            {
              name: "isCallOption",
              type: "bool",
              indexed: false,
              internalType: "bool",
            },
            {
              name: "strikePrice",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "premium",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "expiry",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "amountPurchasing",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "purchaseId",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "event",
          name: "Transfer",
          inputs: [
            {
              name: "from",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "to",
              type: "address",
              indexed: true,
              internalType: "address",
            },
            {
              name: "value",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "purchaseId",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
            {
              name: "timestamp",
              type: "uint256",
              indexed: false,
              internalType: "uint256",
            },
          ],
          anonymous: false,
        },
        {
          type: "error",
          name: "ReentrancyGuardReentrantCall",
          inputs: [],
        },
        {
          type: "error",
          name: "TransferFailed_ETH",
          inputs: [],
        },
        {
          type: "error",
          name: "Unauthorized_ETH",
          inputs: [],
        },
        {
          type: "error",
          name: "WorngValue_ETH",
          inputs: [
            {
              name: "value",
              type: "uint256",
              internalType: "uint256",
            },
          ],
        },
      ],
      inheritedFunctions: {},
    },
  },
} as const;

export default externalContracts satisfies GenericContractsDeclaration;
