// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract Owned {
    address immutable owner;

    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }
}

contract VolcanoCoin is Owned {
    uint16 supply;
    event NewSupply(uint16 _newSupply);

    struct User { 
        address userAddress;
        uint16 balance;
    }

    User user = User(msg.sender, 0);

    constructor() {
        supply = 10000; // Initial coins available
        user.balance = supply;
    }

    function getSupply() public view returns (uint16) {
        return supply;
    }
    
    function setSupply() public onlyOwner {
        supply = supply + 1000;
        emit NewSupply(supply);
    }

    function getBalance() public view returns (uint16) {
        return user.balance;
    }

    struct Payment {
        address recipient;
        uint16 transferAmount;
    }

    mapping(address => Payment[]) sentPayments;

    event PaymentMade(uint16 _amount, address _recipient);

    function transfer(uint16 _amount, address _recipient) public {
        require(_amount > 0, "Amount must be > 0");

        user.balance = user.balance - _amount;
        
        User memory recipient;
        recipient.userAddress = _recipient;
        recipient.balance = recipient.balance + _amount;

        sentPayments[msg.sender].push(Payment({recipient: _recipient, transferAmount: _amount}));
        emit PaymentMade(_amount, _recipient);
    }
    
    // For some reason it returns a "tuple" instead of a list of Payment
    function getPayments(address _sender) public view returns (Payment[] memory) {
        return sentPayments[_sender];
    }
    
    // Alternative to actually return a list of Payment[]
    // function getPayments(address _sender) public view returns (Payment[] memory) {
    //     Payment[] memory payments = new Payment[](sentPayments[_sender].length);
    //     for (uint i=0; i < sentPayments[_sender].length; i++) {
    //         payments[i] = Payment(sentPayments[_sender][i].recipient, sentPayments[_sender][i].transferAmount);
    //     }
    //     emit payments;
    // }
}
