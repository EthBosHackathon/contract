// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Events {
    event Mint(
        address indexed renterWallet,
        uint256 expiredTime,
        uint256 tokenId
    );
    event Burn(uint256 tokenId);
}
