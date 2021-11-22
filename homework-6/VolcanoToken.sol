// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract VolcanoToken is Ownable, ERC721 {
    uint256 tokenId;
    
    constructor() ERC721("VulcanoToken", "VULT") {}

    struct TokenMetadata {
        uint256 timestamp;
        uint256 tokenId;
        string tokenUri;
    }
    
    mapping(address => TokenMetadata[]) public tokensOwnership;

    function mintToken(address _userAddress, uint256 _tokenId) public returns (bool) {
        uint256 tokenId = getTokenId();
        TokenMetadata memory newTokenData = TokenMetadata(block.timestamp, _tokenId, tokenURI(_tokenId));
        _safeMint(_userAddress, _tokenId);
        tokensOwnership[_userAddress].push(newTokenData);
        return true;
    }

    function getUserTokensIds(address _userAddress) internal view returns (uint256[] memory) {
        TokenMetadata[] memory tokensMetadata = tokensOwnership[_userAddress];
        uint256[] memory tokensIds;
        for (uint i=0; i < tokensMetadata.length; i++) {
            tokensIds[i] = tokensMetadata[i].tokenId;
        }
    }
    
    function validateUser(address _userAddress, uint256 _tokenId) internal view returns (bool) {
        uint256[] memory tokensIds = getUserTokensIds(_userAddress);
    
        for (uint i=0; i < tokensIds.length; i++) {
            if (tokensIds[i] == _tokenId) {
                return true;
            }
        }
        return false;
    }

    function burnToken(uint256 _tokenId) public returns (bool) {
        require(validateUser(msg.sender, _tokenId), "User is not the token owner!");
        removeTokenFromArray(_tokenId, msg.sender);
        _burn(_tokenId);
        return true;
    }

    function removeTokenFromArray(uint256 _tokenId, address _userAddress) internal {
        TokenMetadata[] memory tokensMetadata = tokensOwnership[_userAddress];

        for (uint i=0; i < tokensMetadata.length; i++) {
            if (tokensMetadata[i].tokenId == _tokenId) {
                delete tokensOwnership[_userAddress][i];
            }
        }
    }

12. We need to remove the token from the mapping. Make an function that deletes the
token from the mapping. You can make this an internal function, which can then be
called within the burn function.
}
