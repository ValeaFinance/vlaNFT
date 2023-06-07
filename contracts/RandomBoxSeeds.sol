// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// Importing the necessary OpenZeppelin and Chainlink contracts
import "@openzeppelin/contracts/utils/Strings.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

/**
 * @title RandomBoxSeeds
 * @notice This contract is responsible for generating random seeds used for Vale Finance Mystery Treasures NFTs.
 * It's built on the Chainlink VRF (Verifiable Random Function) to ensure the randomness is verifiable and secure.
 * @notice !! The initial configuration data is set for Mumbai Network, when launched on Polygon Mainet it will be updated !!
 */
contract RandomBoxSeeds is VRFConsumerBaseV2 {
    //////////////////
    //  CHAINLINK   //
    //////////////////

    // Instance of the Chainlink VRF Coordinator contract
    VRFCoordinatorV2Interface COORDINATOR;

    // KeyHash value provided by Chainlink VRF for randomness generation
    bytes32 keyHash =
        0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;

    // Gas limit for the callback function that Chainlink VRF will call when randomness is available
    uint32 callbackGasLimit = 2500000;

    // The number of block confirmations that the VRF request must have before it is fulfilled
    uint16 requestConfirmations = 3;

    // Address of the Chainlink VRF Coordinator on Polygon MUMBAI testnet
    address VRFCoordinatorAddress = 0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed;

    // Chainlink VRF subscription ID
    uint64 s_subscriptionId = 0;

    // Storage for the random seeds generated for each Box
    uint256[][] BoxSeeds;

    // The address of the contract owner
    address i_owner;

    /**
     * @notice Constructor function sets the VRF Coordinator address and assigns the contract owner
     */
    constructor() VRFConsumerBaseV2(VRFCoordinatorAddress) {
        // Set the VRF Coordinator instance
        COORDINATOR = VRFCoordinatorV2Interface(VRFCoordinatorAddress);

        // Assign the contract deployer as the owner
        i_owner = msg.sender;
    }

    /**
     * @notice Callback function that is called by Chainlink VRF coordinator when the randomness is ready
     */
    function fulfillRandomWords(
        uint256 _requestId,
        uint256[] memory _randomWords
    ) internal override {
        // Unused variable to avoid solidity warning
        if (false) {
            _requestId;
        }

        // Store the random words to the BoxSeeds array
        BoxSeeds.push(_randomWords);
    }

    /**
     * @notice Allows setting of the VRF subscription ID
     * @param value New subscription ID
     */
    function setSubscriptionId(uint64 value) external {
        s_subscriptionId = value;
    }

    /**
     * @notice Allows setting of the callback gas limit for VRF requests
     * @param value New callback gas limit
     */
    function setCallBackGasLimit(uint32 value) external {
        callbackGasLimit = value;
    }

    /**
     * @notice Allows setting of the keyHash value for VRF requests
     * @param value New keyHash value
     */
    function setKeyHash(bytes32 value) external {
        keyHash = value;
    }

    /**
     * @notice Sends a request for random words to the VRF Coordinator
     * @param numWords Number of random words to request
     */
    function requestSeeds(uint32 numWords) external {
        require(i_owner == msg.sender, "Only Owner");

        uint256 requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );

        // Unused variable to avoid solidity warning
        if (false) {
            requestId;
        }
    }

    /**
     * @notice Get the seeds of a specific Box
     * @param index The index of the Box
     * @return The array of seeds for the Box
     */
    function getSeeds(uint256 index) public view returns (uint256[] memory) {
        return BoxSeeds[index];
    }
}
