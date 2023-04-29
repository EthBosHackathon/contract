// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface INFBnb {
    // Function
    function mint(
        address _propertyOwner,
        uint256 _rentalAmount,
        uint256 _expiresAt
    ) external payable;

    function burn() external;
}
