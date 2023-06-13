// SPDX-License-Identifier: MIT

// 1. Deploy Mock when we r on local chain
// 2. Keep track of contract address across different chains
// Sepolia ETH/USD
// Mainnet ETH/USD 

pragma solidity ^0.8.17;

import{Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";
contract HelperConfig is Script{
//If we r on local chain ,we deploy mock;
//Otherwise grab the existing address from the live network
uint8 public constant DECIMALS=8;
int256 public constant INITIAL_PRICE=2000e8;
struct NetworkConfig{
    address priceFeed;
}

NetworkConfig public activeNetworkConfig;

constructor(){
    if(block.chainid==11155111){
        activeNetworkConfig=getSepoliaEthConfig();
    }else{
        activeNetworkConfig=getOrCreateAnvilEthConfig();
    }
}
function getSepoliaEthConfig() public pure 
            returns(NetworkConfig memory){
    NetworkConfig memory sepoliaConfig =NetworkConfig({
        priceFeed:0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaConfig;
}

function getOrCreateAnvilEthConfig() public  returns (NetworkConfig memory){
    //If mock pricefeed already deployed return deployed address..
    
    if(activeNetworkConfig.priceFeed !=address(0)){
        return activeNetworkConfig;
    }
     //Deploy mock contracts---return their address...
     vm.startBroadcast();
     MockV3Aggregator mockaggregator=new MockV3Aggregator(DECIMALS,INITIAL_PRICE);
     vm.stopBroadcast();

     NetworkConfig memory anvilconfig= NetworkConfig({priceFeed:address(mockaggregator)});
     return anvilconfig;
}}
