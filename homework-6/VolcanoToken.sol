// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract VolcanoToken is Ownable, ERC721 {
    uint256 private tokenId = 1;
    
    constructor() ERC721("VulcanoToken", "VULT") {}

    struct TokenMetadata {
        uint256 timestamp;
        uint256 tokenId;
        string tokenUri;
    }
    
    mapping(address => TokenMetadata[]) tokensOwned;

    function getTokenId() public view returns(uint256) {
        return tokenId;
    }
    
    function getTokensOwned() public view returns(TokenMetadata[] memory) {
        return tokensOwned[msg.sender];
    }

    function mintToken(address payable _userAddress) public payable {
        string memory tokenURI = string(abi.encodePacked("http://api.gattes.me/token/", Strings.toString(tokenId)));
        TokenMetadata memory newTokenData = TokenMetadata(block.timestamp, tokenId, tokenURI);
        tokensOwned[_userAddress].push(newTokenData);
        _safeMint(_userAddress, tokenId);
        tokenId++;
    }

    function getUserTokenIds(address _userAddress) internal view returns (uint256[] memory) {
        uint256[] memory tokenIds;
        TokenMetadata[] memory tokensMetadata = tokensOwned[_userAddress];

        for (uint i=0; i < tokensMetadata.length; i++) {
            tokenIds[i] = tokensMetadata[i].tokenId;
        }

        return tokenIds;
    }
    
    function validateUser(address _userAddress, uint256 _tokenId) internal view returns (bool) {
        uint256[] memory tokensIds = getUserTokenIds(_userAddress);
    
        for (uint i=0; i < tokensIds.length; i++) {
            if (tokensIds[i] == _tokenId) {
                return true;
            }
        }
        return false;
    }

    function burnToken(uint256 _tokenId) public payable {
        require(validateUser(msg.sender, _tokenId), "User is not the token owner!");

        //_burn(_tokenId);

        //removeToken(_tokenId, msg.sender);
        
    }

    function removeToken(uint256 _tokenId, address _userAddress) internal {
        TokenMetadata[] memory tokensMetadata = tokensOwned[_userAddress];

        for (uint i=0; i < tokensMetadata.length; i++) {
            if (tokensMetadata[i].tokenId == _tokenId) {
                delete tokensOwned[_userAddress][i];
            }
        }
    }
}
