pragma solidity ^0.8.0;

contract QualityContract{
    address public owner;

    struct QualityContractData{
        string contractName;
        address[] stakeholders;
        string qualityCriteria;
        bool isCompleted;
    }
    
    mapping(uint256 => QualityContractData) public qualityContracts;
    uint256 public contractCount;

    event QualityContractCreated(uint256 contractId, string contractName, address[] stakeholders, string qualityCriteria);

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this");
        _;
    }
    // Function to create a new quality contract
    function createQualityContract(string memory _contractName, address[] memory _stakeholders, string memory _qualityCriteria) public
    onlyOwner {
     // Increment contractCount to generate a unique contract ID
    contractCount++;
    // Create a new quality contract and store it in the qualityContracts mapping
    qualityContracts[contractCount] = QualityContractData(_contractName, _stakeholders, _qualityCriteria, false);
    // Emit an event to signify the creation of a new quality contract
    emit QualityContractCreated(contractCount, _contractName, _stakeholders, _qualityCriteria);

    }

    function completeQualityContract(uint256 _contractId) public onlyOwner {
        // Check if the provided contract ID is valid
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");
        // Mark the quality contract as completed
        qualityContracts[_contractId].isCompleted = true;
        }
        // Function to get details of a specific quality contract based on its ID
        function getQualityContractDetails(uint256 _contractId) public view returns (string memory, address[] memory, string memory, bool) {
        // Check if the provided contract ID is valid
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");
        // Retrieve and return the details of the specified quality contract
        QualityContractData storage contractData = qualityContracts[_contractId];
        return (contractData.contractName, contractData.stakeholders, contractData.qualityCriteria, contractData.isCompleted);
    }

    function performQualityCheck(uint256 _contractId) public {
        // Check if the provided contract ID is valid
        require(_contractId > 0 && _contractId <= contractCount, "Invalid contract ID");
        // Check if the caller is one of the stakeholders
        bool isStakeholder = false;
        for (uint i = 0; i < qualityContracts[_contractId].stakeholders.length; i++) {
        if (qualityContracts[_contractId].stakeholders[i] == msg.sender) {
        isStakeholder = true;
        break;
        }
        }
        require(isStakeholder, "Only stakeholders can perform quality check");
        // Perform quality check logic (replace with actual quality check logic)
        // For demonstration purposes, we just set the contract as completed
        qualityContracts[_contractId].isCompleted = true;
    }

}