// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CheapGrab.sol";

contract GrabValueTest is Test {
    CheapGrab public cheapGrab;

    function setUp() public {
        cheapGrab = new CheapGrab();
    }

    function testGrabValue() public {
        address payable owner = payable(address(0x94292));
        vm.deal(cheapGrab.getGrabAddress(owner), 1 ether);
        vm.startPrank(owner);
        uint256 startingBalance = owner.balance;
        CheapGrab.Command[] memory commands = new CheapGrab.Command[](0);
        cheapGrab.grab(commands);
        assertEq(owner.balance, startingBalance + 1 ether);
    }
}
