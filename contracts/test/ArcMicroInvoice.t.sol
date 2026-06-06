// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ArcMicroInvoice.sol";
import "../src/MockUSDC.sol";

contract ArcMicroInvoiceTest is Test {
    MockUSDC usdc;
    ArcMicroInvoice app;
    address alice = address(0xA11CE);
    address bob = address(0xB0B);

    function setUp() public {
        usdc = new MockUSDC();
        app = new ArcMicroInvoice(address(usdc));
        usdc.mint(alice, 1_000 * 1e6);
    }

    function testCreateAndPayRecord() public {
        vm.prank(alice);
        uint256 id = app.createRecord(bob, 25 * 1e6, "arc payment");

        vm.startPrank(alice);
        usdc.approve(address(app), 25 * 1e6);
        app.pay(id);
        vm.stopPrank();

        assertEq(usdc.balanceOf(bob), 25 * 1e6);
    }

    function testCannotPayTwice() public {
        vm.prank(alice);
        uint256 id = app.createRecord(bob, 1 * 1e6, "once");
        vm.startPrank(alice);
        usdc.approve(address(app), 2 * 1e6);
        app.pay(id);
        vm.expectRevert(bytes("SETTLED"));
        app.pay(id);
        vm.stopPrank();
    }
}
