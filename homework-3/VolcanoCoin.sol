// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    uint16 supply = 10000; // 10k supply limit
    address owner;
    event NewSupply(uint16 _newSupply);

    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }

    function getSupply() public view returns (uint16) {
        return supply;
    }
    
    function setSupply() public onlyOwner {
        supply = supply + 1000;
        emit NewSupply(supply);
    }
}
