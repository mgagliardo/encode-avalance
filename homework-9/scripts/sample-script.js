const { Wallet } = require("ethers");
const { ethers } = require("hardhat");

// Test on rinkeby
// const provider = new ethers.providers.getDefaultProvider("rinkeby");

const provider = new ethers.providers.WebSocketProvider('ws://127.0.0.1:8545');

async function basicProvider() {
  let blockNumber = await provider.getBlockNumber();
  console.log("Current block number ", blockNumber);

  let balance = await provider.getBalance(
    "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266"
  );

  balance = ethers.utils.formatEther(balance);

  console.log("Balance in ETH: ", balance);

  let block = await provider.getBlock(blockNumber - 1);
  console.log(block)
}

// Coming from the hardhat node
const myWallet01 = new ethers.Wallet(
  "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80",
  provider
);

// Coming from the hardhat node
const myWallet02 = new ethers.Wallet(
  "0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d",
  provider
);

// If no provider specified:
// myWallet01.connect(provider);

async function sendingTx() {
  let myAddr = await myWallet01.getAddress();
  console.log("Address: ", myAddr);

  let balance = await provider.getBalance(myAddr);
  console.log("Balance in ETH: ", balance);

  let txResponse = await myWallet01.sendTransaction({
    to: '0x70997970c51812dc3a010c7d01b50e0d17dc79c8',
    value: ethers.utils.parseEther('1.2'),
  });

  console.log(txResponse);

  let txReceipt = await txResponse.wait();
  console.log("tx Receipt ", txReceipt);
}

async function deployContract() {
  const volcanoContract = await ethers.getContractFactory(
    'VolcanoCoin',
    myWallet01
  );

  const contract = await volcanoContract.deploy();

  await contract.deployed();

  console.log("current contract addr: ", contract.address);
}

async function connectToContract() {
  // Coming from line #64
  let contractAddr = "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707";
  const volcanoContract = await ethers.getContractAt(
    "VolcanoCoin",
    contractAddr,
    myWallet01
  );

  let name = await volcanoContract.name();
  console.log("Contract name: ", name);

  let txResponse = await volcanoContract.transfer(myWallet02.address, 10);
  await txResponse.wait();

  let ownerBalance = await volcanoContract.balanceOf(myWallet01.address);
  console.log('owner balance: ', ownerBalance.toString());
  let otherUserBalance = await volcanoContract.balanceOf(myWallet02.address);
  console.log("Other User balance: ", otherUserBalance.toString());

  let refundTx = await volcanoContract
    .connect(myWallet02)
    .transfer(myWallet01.address, 20);

  await refundTx.wait();

  let ownerBalance2 = await volcanoContract.balanceOf(myWallet01.address);
  console.log("owner balance 2: ", ownerBalance2.toString());
  let otherUserBalance2 = await volcanoContract.balanceOf(myWallet02.address);
  console.log("Other User balance 2: ", otherUserBalance2.toString());
}

// basicProvider()
// sendingTx()
// deployContract()

connectToContract()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
