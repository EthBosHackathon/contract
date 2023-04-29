// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Events {
    event NewRentalListing(
        address indexed propertyOwnerAddress,
        uint256 propertyId
    );
    event Burn(uint256 tokenId);
}
