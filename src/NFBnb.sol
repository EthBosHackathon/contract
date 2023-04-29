// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./interface/INFBnb.sol";

import {DataTypes} from "./libs/DataTypes.sol";
import {Events} from "./libs/Events.sol";

// this countract allows renters to mint a token and transfer the nft to the renter's wallet
// it allows renter to burn it
//

contract NFBnb is INFBnb, ERC721, Ownable {
    // Keep track of tokenId;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdTracker;

    uint private unlocked = 1;
    modifier lock() {
        require(unlocked == 1, "CONTRACT LOCKED");
        unlocked = 0;
        _;
        unlocked = 1;
    }

    // mapping for tokenId(PropertyId) -> address(property owner) -> renter
    mapping(uint256 => mapping(address => DataTypes.Renter)) public renters;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
        _tokenIdTracker.increment();
    }

    function mint(
        address _propertyOwner,
        uint256 _rentalAmount,
        uint256 _expiresAt
    ) external payable lock {
        uint256 tokenId = _tokenIdTracker.current();
        DataTypes.Renter memory newRenter = DataTypes.Renter({
            renterAddress: msg.sender,
            expiresAt: _expiresAt
        });
        renters[tokenId][payable(_propertyOwner)] = newRenter;
        _safeMint(msg.sender, tokenId);
        emit Events.Mint(msg.sender, _expiresAt, tokenId);
    }

    function burn() external {}
}
