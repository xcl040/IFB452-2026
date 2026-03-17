// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
contract EtherUnits {
uint public oneWei = 1 wei;
// 1 wei is equal to 1
bool public isOneWei = 1 wei == 1;
uint public oneEther = 1 ether;
// 1 ether is equal to 10^18 wei
bool public isOneEther = 1 ether == 1e18;
}

contract Gas {
        uint public i = 0;
        // Using up all of the gas that you send causes your transaction to fail.
        // State changes are undone.
        // Gas spent are not refunded.
        function forever() public {
        // Here we run a loop until all of the gas are spent
        // and the transaction fails
        while (true) {
        i += 1;
        }
    }
}