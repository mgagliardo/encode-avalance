const { Wallet } = require("ethers");
const { ethers, upgrades } = require("hardhat");

const provider = new ethers.providers.WebSocketProvider('ws://127.0.0.1:8545');

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

async function deployContract() {
  // Deploying
  const VolcanoCoin = await ethers.getContractFactory("VolcanoCoin");

  const instance = await upgrades.deployProxy(
    VolcanoCoin,
    [myWallet02.address],
    { kind: "uups" }
  );
  const address = (await instance.deployed()).address;
  console.log("Main contract Address:", address);

  // Upgrading
  const VolcanoCoinV2 = await ethers.getContractFactory("VolcanoCoinV2");
  const upgraded = await upgrades.upgradeProxy(
    instance.address,
    [myWallet02.address],
    VolcanoCoinV2
  );
  console.log("Upgraded contract address:", upgraded.address);
}

deployContract()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
