// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Payable {
    // payable address can receive Ether
    address payable public owner;

    // payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
    }

    //function to deposit ether into this contract
    // call this function along with some ether
    // the balance of this contract will be automatically update
    function deposit() public payable {}

    // call this function along with some ether
    // the function will be throw an error since this function is not payable
    function notPayable() public {}

    //function to withdraw all ether from this contract
    function withdraw() public {
        // get the amount of ether stored in this contract
        uint amount = address(this).balance;

        //send all ether to owner
        // owner can receive ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "failed to send ether");
    }

    // function to transfer ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public {
        (bool success, )  = _to.call{value: _amount}("");
        require(success, "failed to send ether");
    }
}