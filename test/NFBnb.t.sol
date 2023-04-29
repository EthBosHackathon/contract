// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NFBnb.sol";

contract NFBnbTest is Test {
    NFBnb public nfBnb;
    address propertyOwner1 = address(1);
    address renter1 = address(2);
    address propertyOwner2 = address(3);
    address renter3 = address(4);

    function setUp() public {
        nfBnb = new NFBnb("NFT AIRBNB", "NFTBNB");
    }

    function testContractBasicInfo() public {
        assertEq(nfBnb.name(), "NFT AIRBNB");
        assertEq(nfBnb.symbol(), "NFTBNB");
    }

    function testMint() public {
        vm.deal(renter1, 1 ether);
        vm.prank(renter1);
        nfBnb.mint(propertyOwner1, 0.5 ether, block.timestamp + 2 weeks);
        vm.stopPrank();
        assertEq(nfBnb.ownerOf(1), renter1);
    }
}
