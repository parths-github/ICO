// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**Every Crypto Dev NFT holder should get 10 tokens for free but they would have to pay the gas fees.
 * The price of one CD at the time of ICO should be 0.001 ether 
 * There should be a max of 10,000 CD tokens.
 */

 // Here we have to call the functions of CryptoDev contract so that we can know who holds the nft : 0x1b07600e6DD5F8B0Beb98148C074495330f29681

// Reason we are using interface instead of whole contract is if if write whole contrcat here we also have to deploy it and it costs more gas.
// So we are just having the function we need to call in ICo contract
interface ICryptoDevs {
    // We need the index coz we want to restrict the user to have 10 CD tokens per NFT 
    /**
     * @dev Returns a token ID owned by `owner` at a given `index` of its token list.
     * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId);
    function balanceOf(address owner) external view returns (uint256 balance);
    }




