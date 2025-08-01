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

### Install dependencies
```shell
$ forge install smartcontractkit/chainlink-brownie-contracts@1.1.1 --no-commit
```

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
$ forge test --match-test testPriceFeedVersionIsAccurate -vvvv --fork-url $SEPOLIA_RPC_URL
$ forge coverage --match-test testPriceFeedVersionIsAccurate -vvv --rpc-url $SEPOLIA_RPC_URL
$ forge coverage -vvv --fork-url $SEPOLIA_RPC_URL
$ forge coverage --fork-url $SEPOLIA_RPC_URL
$ forge test --fork-url $SEPOLIA_RPC_URL
$ forge test --fork-url $LOCAL_RPC_URL
$ forge test --fork-url $ETH_MAINNET_RPC_URL -vvvv
$ forge snapshot --match-test testWithdrawFromMultipleFunders
$ forge script script/DeployFundMe.s.sol --rpc-url $LOCAL_RPC_URL --private-key $LOCAL_PRIVATE_KEY --broadcast
$ forge install ChainAccelOrg/foundry-devops --no-commit

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
