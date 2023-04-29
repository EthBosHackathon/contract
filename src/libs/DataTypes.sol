// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

library DataTypes {
    struct Renter {
        address renter; // address of renter
        uint64 expires; // unix timestamp, rent expires
    }

    struct Property {
        address ownerAddress;
        uint256 pricePerDay;
    }
}
