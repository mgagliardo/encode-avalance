// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.2.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.2.0/token/ERC20/ERC20.sol"; 

contract VolcanoCoin is Ownable, ERC20 {

    constructor() ERC20("VulcanoCoin", "VULC") {
        supply = 10000;
        user.balance = supply;
        _mint(msg.sender, supply);
    }

    uint256 supply;
    event NewSupply(uint256 _newSupply);

    struct User { 
        address userAddress;
        uint256 balance;
    }

    User user = User(msg.sender, 0);
    
    function changeTokenSupply() public onlyOwner {
        _mint(msg.sender, 1000);
    }

    function getBalance() public view returns (uint256) {
        return user.balance;
    }
    
    function mintTokensToOwner() public onlyOwner {
        _mint(msg.sender, 1000);
    }

    struct Payment {
        address recipient;
        uint256 transferAmount;
    }

    event PaymentRecord(uint256 _amount, address _recipient);
    mapping(address => Payment[]) public sentPayments;

    function transferFrom(address _sender, address _receiver, uint256 _amountTokens) public override returns (bool) {
        require(_amountTokens > 0, "Amount must be > 0");
        require(_amountTokens <= getBalance());

        user.balance = user.balance - _amountTokens;
        transfer(_receiver, _amountTokens);
    
        emit Transfer(_sender, _receiver, _amountTokens);
        emit PaymentRecord(_amountTokens, _receiver);
        createPaymentRecord(_sender, _receiver, _amountTokens);

        return true;
    }


    function createPaymentRecord(address _sender, address _receiver, uint256 input) public {
        sentPayments[_sender].push(Payment({recipient: _receiver, transferAmount: input}));
    }
    
}
