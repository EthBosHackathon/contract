// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./interface/IPropertyOwnerListing.sol";

import {DataTypes} from "./libs/DataTypes.sol";
import {Events} from "./libs/Events.sol";

// this countract allows renters to mint a token and transfer the nft to the renter's wallet
// it allows renter to burn it
//

contract PropertyOwnerListing is
    IPropertyOwnerListing,
    ERC721URIStorage,
    Ownable
{
    // Keep track of tokenId;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => DataTypes.Property) public listingProperties;

    constructor() ERC721("NFT BNB", "NFTBNB") {}

    function listingProperty(
        uint256 _pricePerDay,
        string memory _propertUri
    ) external returns (uint256 _newPropertyId) {
        DataTypes.Property memory newListing = DataTypes.Property({
            ownerAddress: msg.sender,
            pricePerDay: _pricePerDay
        });
        _newPropertyId = _tokenIds.current();
        listingProperties[_newPropertyId] = newListing;
        _safeMint(msg.sender, _newPropertyId);
        _setTokenURI(_newPropertyId, _propertUri);
        emit Events.NewRentalListing(msg.sender, _newPropertyId);
        return _newPropertyId;
    }
}
