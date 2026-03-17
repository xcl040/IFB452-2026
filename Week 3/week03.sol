// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QualityContract{
    mapping(address=> bool)public stakeholders;
    uint256 public qualityScore;
    uint8 constant stakeholderMAXNumber = 2;
    uint8 public stakeholderNumber;

    modifier onlyStakeholder(){
    require(stakeholders[msg.sender],"Only authorised stakeholder can execute this");
    _;
    }
    modifier exceedTwoStakeholder(uint8 SHnumber){
        require(SHnumber > stakeholderMAXNumber, "Must not add exceed two stakeholder");
        _;
    }

    constructor(address[] memory initialStakeholders) exceedTwoStakeholder(initialStakeholders.length){
        for(uint256 i=0; i<initialStakeholders.length;i++){
            stakeholders[initialStakeholders[i]]=true;
        }
        qualityScore=0;
        stakeholderNumber = initialStakeholders.length;
    }
        

        function updateQualityScore(uint256 newScore)external onlyStakeholder{
            qualityScore=newScore;
        }
        function addStakeholder(address newStakeholder)external onlyStakeholder{
            stakeholders[newStakeholder]=true;
        }
    }
    
