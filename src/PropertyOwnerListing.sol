// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./interface/IPropertyOwnerListing.sol";

import "./ERC4907.sol";

import {DataTypes} from "./libs/DataTypes.sol";
import {Events} from "./libs/Events.sol";

// this countract allows renters to mint a token and transfer the nft to the renter's wallet
// it allows renter to burn it
//

contract PropertyOwnerListing is IPropertyOwnerListing, ERC4907, Ownable {
    // Keep track of tokenId;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => DataTypes.Property) public listingProperties;

    constructor() ERC4907("NFT BNB", "NFTBNB") {}

    modifier onlyPropertyOwner(uint256 _propertyId, address _propertyOwner) {
        DataTypes.Property memory property = listingProperties[_propertyId];
        address owner = property.ownerAddress;
        require(owner == _propertyOwner, "No able to remove property listing");
        _;
    }

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

    function burn(
        uint256 _propertyId
    ) external onlyPropertyOwner(_propertyId, msg.sender) {
        super._burn(_propertyId);
    }
}
