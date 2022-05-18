// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ICryptoDevs.sol";


contract CryptoDevToken is ERC20, Ownable {

    ICryptoDevs CrytpoDevsNFT;
    // 1 = 10**-18
    // 10**-18 * 10**18 = 1 token
    uint256 public constant tokensPerNft = 10 * 10**18;
    // To keep trcak of claimed tokenIds
    mapping(uint256 => bool) public tokenIdsClaimed;
    // Price per token (To buy - for general public)
    uint256 public constant price = 0.001 ether; 
    // Max total supply of token
    uint256 public constant maxTotalSupply = 10000 * 10**18;
    constructor(address _cryptoDevContrcat) ERC20("Crypto Dev Token", "CD") {
        CrytpoDevsNFT = ICryptoDevs(_cryptoDevContrcat);
    }

    /** 
     * @dev mint and transfer 10 CD per nft to NFT holder
     */
    // Here we could have set the mapping from account to bool - checking that each user have minted the nft successfully. 
    // But users can again go to cryptoDev contrcat and mint some other nft or they simply can transfer the nft to other account and then the new account would be able to cliam. 
    // So to prevent both of this problem we are setting mapping from tokenId to boolean this way definately each user would get 10 CD per cryptoDevNFT
    function claim() public {
        uint256 balance = CrytpoDevsNFT.balanceOf(msg.sender);
        require(balance > 0, "You don't have any CryptoDev NFT");
        // To keep trcak of how many NFTs are yet to be claimed by caller
        uint256 amount = 0;
        for (uint256 i; i < balance; i++) {
            // We are getting the tokenId at particular index of owner 
            uint256 tokenId = CrytpoDevsNFT.tokenOfOwnerByIndex(msg.sender, i); 
            // If the id is not claimed
            if (!tokenIdsClaimed[tokenId]) {
                tokenIdsClaimed[tokenId] = true;
                amount++;
            }
        }
        require(amount > 0, "You have already claimed all tokens");
        _mint(msg.sender, amount*tokensPerNft);

    }


    /**
     * @dev for general public- they can buy the token with set price 
     */
    function mint(uint256 _amount) public payable {
        uint256 requiredAmount = _amount * price;
        require(msg.value >= requiredAmount, "Not enough price");
        require(_amount > 0, "Invalid amount");
        uint256 amountWithDecimal = _amount * 10**18;
        // Check that total supply is less than maximum supply
        require(totalSupply() + amountWithDecimal <= maxTotalSupply, "Maximum limit reached");
        _mint(msg.sender, amountWithDecimal);
    }

    receive() external payable{}

    fallback() external payable{}
}

