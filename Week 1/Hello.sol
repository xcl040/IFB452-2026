// SPDX-License-Identifier:MIT
pragma solidity ^0.8.3;

contract StudentDetail {
    string public studentNo = "n11747064";
    string public studentName = "Xu Chen Loo";

    function getStudentDetail() public view returns (string memory) {
        return string(abi.encodePacked(studentName, " - ", studentNo));
    }
}
    
