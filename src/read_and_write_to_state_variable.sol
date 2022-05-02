// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract SimpleStorage {
    //state variable to store a number
    uint public num;

    //you need to send a transaction to write to a state
    //variable
    function set(uint _num) public {
        num = _num;
    }
    //read from a state variable without send trsaction

    function get() public view returns (uint) {
        return num;
    }
}