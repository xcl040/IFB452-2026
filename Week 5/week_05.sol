// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract PaymentAndRating {

    address public owner;

    mapping(address => uint256) public payments;
    mapping(address => uint256) public ratings;

    uint256 public totalPayments;

    event PaymentReceived(address from, uint256 amount);
    event PaymentSent(address to, uint256 amount);
    event Rated(address user, uint256 rating);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function pay() public payable {
        require(msg.value > 0, "Send some Ether");

        payments[msg.sender] += msg.value;
        totalPayments += msg.value;

        emit PaymentReceived(msg.sender, msg.value);
    }

    function rate(uint256 _rating) public {
        require(_rating >= 1 && _rating <= 5, "Rating must be 1-5");

        ratings[msg.sender] = _rating;

        emit Rated(msg.sender, _rating);
    }

    function sendPayment(address payable _to, uint256 _amount) public onlyOwner {
        require(address(this).balance >= _amount, "Not enough balance");

        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transfer failed");

        emit PaymentSent(_to, _amount);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {
        payments[msg.sender] += msg.value;
        totalPayments += msg.value;

        emit PaymentReceived(msg.sender, msg.value);
    }

    fallback() external payable {}
}