// SPDX-Lincense-Identifier: MIT

// 1. Deploy mocks when we are on a local anvil chain
// 2. Keep track of contract addresses across different chains
// SEPOLIA ETH/USD Address
// Mainnet ETH/USD Address
// https://docs.chain.link/data-feeds/price-feeds/addresses

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import {Strings} from "lib/openzeppelin-contracts/contracts/utils/Strings.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

contract HelperConfig is Script{
    // If we are on a local anvil chain, we will deploy mocks
    // otherwise, grab an existing address from the live network

    NetworkConfig public activeNetworkConfig;

    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8; // 2000 USD in 8 decimals -- 2000 * 10**8

    struct NetworkConfig {
        address priceFeed; // Sepolia ETH/USD Price Feed address
    }

    constructor() {
        console.log("Detected chain ID:", block.chainid);
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            activeNetworkConfig = getMainnetEthConfig();
        } else if (block.chainid == 31337) {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        } else {
            revert(string.concat("test code: ", Strings.toString(block.chainid)));
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory config) {
        // returns price feed address
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306 // Sepolia ETH/USD Price Feed
        });

        return sepoliaConfig;
    }

    function getMainnetEthConfig() public pure returns (NetworkConfig memory config) {
        NetworkConfig memory ethMainnetConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419 // Mainnet ETH/USD Price Feed
        });

        return ethMainnetConfig;
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory config) {
        if (activeNetworkConfig.priceFeed != address(0)) {
            console.log("Using existing price feed address:", activeNetworkConfig.priceFeed);
            return activeNetworkConfig;
        }
        // Deploy a mock price feed if we are on anvil
        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS, INITIAL_PRICE);
        vm.stopBroadcast();

        // return the mock addresses
        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });

        return anvilConfig;
    }
}
