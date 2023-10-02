//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    uint256 number = 1;
    FundMe fundMe;

    function setUp() external {
        // use-> FundMeTest -> FundMe
        // FundMeTest is the owner of fundMe
        DeployFundMe deployfundme = new DeployFundMe();
        fundMe = deployfundme.run();
    }

    function testMiniumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        console.log(
            "Address of the deployer of fundMe contract",
            fundMe.i_owner()
        );
        console.log("Address of the deployer of this contract", address(this));
        console.log("Our address, we are calling fundMeTest", msg.sender);
        assertEq(fundMe.i_owner(), address(this));
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        console.log(version, "Version of the price feed");
        assertEq(version, 4);
    }
}

//What can we do to work with address outside our system?
//1. Unit test
// - We can write unit test to test our contract
// - Testing a specific part of our code
// 2. Integration test
// - Testing how our code works wit other parts of our code
// 3. Forked
// - Tetsing our code on a simulated real environment
// 4. Staging
// - Tseting our code on a real environment that is not production

// we are calling fundmetest and fundMeTest is deploying the FundMe contract
