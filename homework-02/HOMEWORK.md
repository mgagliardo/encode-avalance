# Homework #2

1. Using the blockchain explorer, have a look at the following transactions, what do they do ?
* `0xb9316bbbae1cd21cd824de8651c72582261230724b1957abdeb466aa96a359c9:` Burning tokens probably. Lots of tokens transferred from [The DAO ethereum address](https://etherscan.io/token/0xbb9bc244d798123fde783fcc1c72d3bb8c189413?a=0xe306aac52823ba1d3938608381a2444d9d641cc1) to blackhole (non existent address).
* `0x4fc1580e7f66c58b7c26881cce0aab9c3509afe6e507527f30566fbf8039bcd0:` Creates the Uniswap V2 contract. Verified [here](https://etherscan.io/address/0x7a250d5630b4cf539739df2c5dacb4c659f2488d#code)
* `0x552bc0322d78c5648c5efa21d2daa2d0f14901ad4b15531f1ab5bbe5674de34f:` [Polynetwork's hack](https://www.reddit.com/r/CryptoCurrency/comments/p1sv3t/the_polynetwork_hacker_it_would_have_been_a/). Looking at input data's phrase (as UTF-8).
* `0x7a026bf79b36580bf7ef174711a3de823ff3c93c65304c3acc0323c77d62d0ed:` Hacker returning money to [Polynetwork's multisig address](https://etherscan.io/token/0x6b175474e89094c44da98b954eedeac495271d0f?a=0x71fb9db587f6d47ac8192cd76110e05b8fd2142f). Found [here](https://etherscan.io/token/0x6b175474e89094c44da98b954eedeac495271d0f?a=0x34d6b21d7b773225a102b382815e00ad876e23c2).
* `0x814e6a21c8eb34b62a05c1d0b14ee932873c62ef3c8575dc49bcf12004714eda:` 160 ETH locked into the account after the olynetwork's hack to "inspire security experts". [Link to the blog note](https://smartliquidity.info/2021/08/20/poly-network-latest-updates-aug-19/)

2. What is the largest account balance you can find?

According to [Top accounts by ETH balance](https://etherscan.io/accounts), the top one is ETH 2.0 (PoS) deposit contract, which has about ~8.2M ETH locked/deposited.

3. What is special about these accounts : 
* `0x1db3439a222c519ab44bb1144fc28167b4fa6ee6:` One of two Vitalik's main addresses (the other one is `0xab5801a7d398351b8be11c439e05c5b3259aec9b`). Also funny he can be found on [UBI's Proof of humanity](https://app.proofofhumanity.id/profile/0x1db3439a222c519ab44bb1144fc28167b4fa6ee6).
* `0x000000000000000000000000000000000000dEaD:` Black hole. Mainly used to burn tokens (reduce total supply)
