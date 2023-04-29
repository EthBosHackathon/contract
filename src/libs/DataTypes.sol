// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

library DataTypes {
    /**
     * @notice A struct associate with a renter.
     *
     * @param renterAddress The address for renter for the rental property.
     * @param expiresAt Expires time for the renter's NFT
     */
    struct Renter {
        address renterAddress;
        uint256 expiresAt;
    }

    struct Property {
        address ownerAddress;
        uint256 pricePerDay;
    }
}
