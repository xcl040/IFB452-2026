// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Rating {
    
    address owner;
    string[] users;
    mapping(string => User_Details) rating;
    
    constructor() {
        owner = msg.sender;    
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }
    
    modifier isInitiated(string memory _username) {
        require(rating[_username].isInitited > 0, "User not initiated");
        _;
    }
    
    modifier bothInitiated(string memory _ratingFrom, string memory _ratingto) {
        require(
            rating[_ratingFrom].isInitited > 0 && rating[_ratingto].isInitited > 0,
            "Both users must exist"
        );
        _;
    }
    
    struct User_Details {
        uint rating_total;
        uint times_voted;
        uint isInitited;
    }
    
    event RatingActivity( 
        string indexed rating_from,
        string indexed rating_to,
        uint rating
    );
    
    function addUser(string memory _username) public onlyOwner {
        users.push(_username);
        rating[_username].rating_total = 0;
        rating[_username].isInitited = 1;
        rating[_username].times_voted = 0;
    }
    
    function getUserSize() public view returns(uint) {
        return users.length;
    }
    
    function getUserRating(string memory _username) public view isInitiated(_username) returns(uint) {
        return rating[_username].rating_total;
    }
    
    function getUserTimesVoted(string memory _username) public view isInitiated(_username) returns(uint) {
        return rating[_username].times_voted;
    }
    
    function addRating(
        string memory _ratingFrom,
        string memory _userRated,
        uint256 data
    ) public bothInitiated(_ratingFrom, _userRated) {
        rating[_userRated].rating_total += data;
        rating[_userRated].times_voted++;
        emit RatingActivity(_ratingFrom, _userRated, data);
    }
    
    function getIntegerRating(string memory _userRated) public view returns (uint256) {
        uint total = rating[_userRated].rating_total;
        uint rate_count = rating[_userRated].times_voted;
        require(rate_count > 0, "No ratings yet");
        return total / rate_count;
    }
    
    function getRatingParameters(string memory _userRated) public view returns (uint, uint) {
        return (rating[_userRated].rating_total, rating[_userRated].times_voted);
    }
}