# Valea's Mysterious Treasures Smart Contracts

This repository contains the smart contracts responsible for managing the Valea's Mysterious Treasures NFTs.

-   **ValeaTreasuresNFT.sol**: This is the principal contract encompassing the ERC721 functions, along with additional features designed specifically for this project.
-   **ValeaTreasuresNFTExtra.sol**: This contract manages the royalty and ownership logic.
-   **RandomBoxSeeds.sol**: Utilized for generating random numbers that define each type of NFT.

## ValeaTreasuresNFT.sol

This contract is designed to streamline functionality and reduce redundancy in both logic and functions. The simplification process does not compromise their control mechanisms. Here are some noteworthy modifications:

-   Control mechanisms such as `pause()` and `unpause()` have been consolidated into a `changePause()` function, acting as a switch.
-   Basic principles aimed at avoiding duplicative storage, such as `allowed to mint` and `allowed amount to mint`, have been integrated into a singular function where 0 is the default, and an integer signifies that the user is whitelisted.
-   The number of definitions and functions has been minimized by leveraging control mechanisms like `changePause()`, `setMintPrice`, and `setMintSupply()`, thereby eliminating the need to keep a list of stored variables for each phase.

## RandomBoxSeeds.sol

This contract will be deployed on the Polygon Mainnet to generate NFT types randomly for several reasons:

1. zkSync Era lacks a reliable oracle for random number generation.
2. This method ensures and provides proof that each user's NFT type is randomly generated, promoting transparency and reducing reliance on the team - a common issue in many projects.
3. Polygon is cost-effective for deploying smart contracts, and we need it only as a proof mechanism.

This contract will generate 65 random numbers using ChainLINK oracles. This exact number will be updated on the ValeaTreasuresNFT.sol contract by the team. The first generation will be a test to check that the contract works, so it will only consist of 2 random numbers accessible by calling this contract's function `getSeeds(0)`. The second generation, which uses the 65 numbers, will be accessible at `getSeeds(1)`.

> :warning: **All this information will be hard-coded**: All this information will be hard-coded into the ValeaTreasuresNFT.sol smart contract to ensure complete transparency. This includes the address of this smart contract so that no one can alter the information afterward.

## Disclaimer

This is the fundamental structure of the smart contract that will be used in the MINT phase.

> Please note that this code is not final or immutable as it may undergo improvements for better gas efficiency and security before the official launch. Any minor changes will be updated here as well. Upon the smart contracts' deployment on the blockchain, the addresses will be shared here and on our social media platforms. This way, everyone can directly inspect the code on the blockchain for security purposes.

As this repository is intended for transparency and enabling everyone to read the code, we will not be explaining the reasoning behind each line of code in detail. If you have any questions or curiosity, feel free to ask in our Discord channel, and our team will be happy to answer.
