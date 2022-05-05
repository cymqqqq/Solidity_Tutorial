// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;
contract ReceiveEther {
     /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */
    // function to receive ether, msg.data must be empty
    receive() external payable {}
    
    // fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        //this function is no longer recommended for sending ether
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // send returns a boolean value indicating success or failure
        //this function is not recommended for sending ether
        bool sent = _to.send(msg.value);
        require(sent, "failed to send ether");
    }

    function sendViaCall(address payable _to) public payable {
        // call returns a boolean value indicating success or failure
        // this is the current recommended method to use
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "failed to send ether");
    }
}