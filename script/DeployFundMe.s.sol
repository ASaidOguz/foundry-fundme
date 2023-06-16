// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
contract DeployFundMe is Script{
    address public ethUsdprice;
function run() external returns(FundMe, HelperConfig){
    // Before tx not a real transaction..gas will be lower..
    HelperConfig helperconfig=new HelperConfig();
    ethUsdprice=helperconfig.activeNetworkConfig();
    vm.startBroadcast();
    FundMe fundme=new FundMe(ethUsdprice);
    vm.stopBroadcast();
    return (fundme,helperconfig);
}
}