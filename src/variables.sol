// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Variables {
    //state variables are stores on the blockchain
    string public text = "hello";
    uint public num = 123;

    function  doSome() public {
        uint i = 222;
        uint ts = block.timestamp;
        address sender = msg.sender;
    }
}