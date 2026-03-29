contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
    // This function is no longer recommended for sending Ether.
    _to.transfer(msg.value);
    }
    function sendViaSend(address payable _to) public payable {
    // Send returns a boolean value indicating success or failure.
    // This function is not recommended for sending Ether.
    bool sent = _to.send(msg.value);
    require(sent, "Failed to send Ether");
    }
    function sendViaCall(address payable _to) public payable {
    // Call returns a boolean value indicating success or failure.
    // This is the current recommended method to use.
    (bool sent, bytes memory data) = _to.call{value: msg.value}("");
    require(sent, "Failed to send Ether");
    }
}

contract Payable{
    address payable public owner;
    constructor() payable{
        owner = payable (msg.sender);
    }

    function deposit() public  payable {}

    function notPaybale() public{}

    function withdraw() public {
        uint amount = address (this).balance;

        (bool success,) = owner.call{value:amount}("");
        require(success, "Failed to send Ether");
    }

    function transfer (address payable _to, uint _amount) public {
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }

   
}

contract Fallback{
    event Log(string func, uint gas);

    fallback() external payable {
        emit Log("fallback", gasleft());
     }

    receive() external payable {
        emit Log("receive", gasleft());

     }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}

contract SendToFallback{
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable{
        (bool sent,) = _to.call{value:msg.value}("")
    }
}

