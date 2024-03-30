forked from [TobiasBK/experiments-in-derivatives](https://github.com/TobiasBK/experiments-in-derivatives)

# experiments-in-derivatives

A work in progress...

Plan to work out ideas around:

- Swaps
- Options
- Vaults
- Fractional NFTs
- Indexes 🤔

This repo is built with [Foundry](https://github.com/gakonst/foundry).

**None of this code is meant for production.**

## Reference

- [Perpetual Swaps](https://research.paradigm.xyz/cartoon-guide-to-perps)
- [Everlasting Options](https://www.paradigm.xyz/2021/05/everlasting-options)

---

## modified by youngzhenhao

### forge version

```text
forge 0.2.0
```

### layout

https://book.getfoundry.sh/projects/project-layout

---

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
