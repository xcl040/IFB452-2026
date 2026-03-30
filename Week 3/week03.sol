// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract {

    mapping(address => bool) public stakeholders;
    address[] public stakeholderList;
    uint256 public qualityScore;

    event QualityScoreUpdated(uint256 newScore);
    event StakeholderAdded(address newStakeholder);

    modifier onlyStakeholder() {
        require(stakeholders[msg.sender], "Only stakeholder can execute this");
        _;
    }

    constructor(address[] memory initialStakeholders) {
        require(initialStakeholders.length >= 3, "Need at least 3 stakeholders");

        for (uint i = 0; i < initialStakeholders.length; i++) {
            address stakeholder = initialStakeholders[i];

            require(stakeholder != address(0), "Invalid address");
            require(!stakeholders[stakeholder], "Duplicate stakeholder");

            stakeholders[stakeholder] = true;
            stakeholderList.push(stakeholder);
        }

        qualityScore = 0;
    }

    function updateScore(uint256 newScore) external onlyStakeholder {
        qualityScore = newScore;
        emit QualityScoreUpdated(newScore);
    }

    function addStakeholder(address newStakeholder) external onlyStakeholder {
        require(newStakeholder != address(0), "Invalid address");
        require(!stakeholders[newStakeholder], "Already a stakeholder");

        stakeholders[newStakeholder] = true;
        stakeholderList.push(newStakeholder);

        emit StakeholderAdded(newStakeholder);
    }

    function getStakeholderCount() public view returns (uint256) {
        return stakeholderList.length;
    }

    function isStakeholder(address user) public view returns (bool) {
        return stakeholders[user];
    }
}