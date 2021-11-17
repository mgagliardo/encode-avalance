# Homework 4

1.a. The best data structure is a `struct` with a variable `address`.

1.b.
```
struct User { 
    address userAddress;
    uint16 balance;
}
```

2.a. We can have the variable set as `public`:
```
uint public balance = user.balance;
```

Or else, setup a getter:
```
function getBalance() public view returns(uint) {
    return user.balance;
}
```

4.a. Because the sender address is the one that is interacting with the contract. In this case `user.userAddress`.

4.b. Unsure, but if I would have to say I would go for security and privacy.

5.
```
function transfer(uint16 _volcanoCoins, address _recipient)public {
    // Sum "negative" amount of coins, same as we'll be sending
    user.balance = user.balance - _volcanoCoins;

    // Simulate coins sending here

    emit Deposit(_volcanoCoins, _recipient);
}
```

6.
