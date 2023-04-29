// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/PropertyOwnerListing.sol";

contract PropertyOwnerListingTest is Test {
    PropertyOwnerListing public propertyOwnerListing;
    address propertyOwner1 = address(1);
    address renter1 = address(2);
    address propertyOwner2 = address(3);
    address renter3 = address(4);

    function setUp() public {
        propertyOwnerListing = new PropertyOwnerListing();
    }

    function testContractBasicInfo() public {
        assertEq(propertyOwnerListing.name(), "NFT BNB");
        assertEq(propertyOwnerListing.symbol(), "NFTBNB");
    }

    function testMint() public {
        vm.prank(propertyOwner1);
        propertyOwnerListing.listingProperty(0.5 ether, "");
        vm.stopPrank();
        assertEq(propertyOwnerListing.ownerOf(0), propertyOwner1);
    }
}
