const { ethers } = require("hardhat");


const main = async () => {
    const CryptoDevTokenFactory = await ethers.getContractFactory("CryptoDevToken");
    const CryptoDevToken = await CryptoDevTokenFactory.deploy("0x1b07600e6DD5F8B0Beb98148C074495330f29681");
    await CryptoDevToken.deployed();
    console.log(`CryptoDevToken deployed to: ${CryptoDevToken.address}`);
    console.log(`Verify with: \n npx hardhat verify --network goerli ${CryptoDevToken.address} "0x1b07600e6DD5F8B0Beb98148C074495330f29681"`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log(error);
        process.exit(1);
    })