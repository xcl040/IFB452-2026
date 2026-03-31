// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract{
    address public singleStakeholder;
    uint256 public qualityScore;

    modifier onlyStakeholder() {
        require(
            msg.sender == singleStakeholder, 
            "Only stakeholder can execute this");
        _;
    
    }

    constructor(address initialStakeholder) {
        require(
            initialStakeholder != address(0),
            "Invalid initial stakeholder address"
        );
        singleStakeholder = initialStakeholder;
        qualityScore = 0;
    }

    event updateQualityScore(uint256 newScore);

    function updateScore(uint256 newScore) external onlyStakeholder {
        qualityScore = newScore;
        emit updateQualityScore(newScore);
    }
}