// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Fallback {
    event Log(uint gas);

    //fallback function must be declared as external
    fallback() external payable {
        // send  / transfer 
        // call
        emit Log(gasleft());
    }

    //helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "failed to send ether");
    }
}