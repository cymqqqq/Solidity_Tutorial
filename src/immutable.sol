// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Immutable {
    address public immutable MY_A;
    uint public immutable MY_U;

    constructor(uint _myU) {
        MY_A = msg.sender;
        MY_U = _myU;
    }
}