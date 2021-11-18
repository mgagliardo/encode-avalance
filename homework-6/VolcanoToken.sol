// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.2.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.2.0/token/ERC721/ERC721.sol";


contract VolcanoToken is Ownable, ERC721 {
    uint256 tokenId;
    
    constructor() ERC721("VulcanoToken", "VULT") public {
    }

}
