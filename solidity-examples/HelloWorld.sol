// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract HelloWorld {
    string message;
    
    constructor(string memory initialiseMessage) {
        message = initialiseMessage;
    }
    
    function update(string memory newMessage) public {
        message = newMessage;
    }
    
    function getMessage() public view returns (string memory storedMessage) {
        return message;
    }
}
