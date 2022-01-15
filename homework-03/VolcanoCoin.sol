// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    uint16 supply;
    address owner;
    event NewSupply(uint16 _newSupply);

    constructor() {
        owner = msg.sender;
        supply = 10000; // Initial coins available
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
