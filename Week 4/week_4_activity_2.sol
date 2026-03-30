// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract {
    // Owner / Food Producer
    address public owner;

    struct QualityContractData {
        string contractName;
        address[] stakeholders;
        string qualityCriteria;
        bool isCompleted;
    }

    // Store contracts by ID
    mapping(uint256 => QualityContractData) public qualityContracts;

    // Track total number of contracts
    uint256 public contractCount;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can execute this");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Create a new quality contract
    function createQualityContract(
        string memory _contractName,
        address[] memory _stakeholders,
        string memory _qualityCriteria
    ) public onlyOwner {
        require(bytes(_contractName).length > 0, "Contract name required");
        require(_stakeholders.length > 0, "At least one stakeholder required");
        require(bytes(_qualityCriteria).length > 0, "Quality criteria required");

        contractCount++;

        qualityContracts[contractCount] = QualityContractData({
            contractName: _contractName,
            stakeholders: _stakeholders,
            qualityCriteria: _qualityCriteria,
            isCompleted: false
        });
    }

    // Stakeholders perform quality check
    function performQualityCheck(uint256 _contractId) public {
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");
        require(!qualityContracts[_contractId].isCompleted, "Contract already completed");

        bool stakeholderFound = false;

        for (uint256 i = 0; i < qualityContracts[_contractId].stakeholders.length; i++) {
            if (qualityContracts[_contractId].stakeholders[i] == msg.sender) {
                stakeholderFound = true;
                break;
            }
        }

        require(stakeholderFound, "Only stakeholders can perform quality check");

        // For demo purpose, mark as completed after quality check
        qualityContracts[_contractId].isCompleted = true;
    }

    // Only owner can complete a quality contract
    function completeQualityContract(uint256 _contractId) public onlyOwner {
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");
        qualityContracts[_contractId].isCompleted = true;
    }

    // Get details of a specific quality contract
    function getQualityContractDetails(uint256 _contractId)
        public
        view
        returns (
            string memory,
            address[] memory,
            string memory,
            bool
        )
    {
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");

        QualityContractData storage contractData = qualityContracts[_contractId];

        return (
            contractData.contractName,
            contractData.stakeholders,
            contractData.qualityCriteria,
            contractData.isCompleted
        );
    }
}