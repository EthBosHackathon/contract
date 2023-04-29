// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IPropertyOwnerListing {
    // Function
    function listingProperty(
        uint256 _pricePerDay,
        string memory _propertUri
    ) external returns (uint256 _newPropertyId);
}
