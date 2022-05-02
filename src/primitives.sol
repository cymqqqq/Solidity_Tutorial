// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Primitives {
    bool public boo = true;

    uint8 public u8 = 1;
    uint public u256 = 456;
    uint public u = 123;

    int8 public i8 = -1;
    int public i256 = 235;

    //minimum and maximum of int
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    /*
    In Solidity, the data type byte represent a sequence of bytes. 
    Solidity presents two type of bytes types :

     - fixed-sized byte arrays
     - dynamically-sized byte arrays.
     
     The term bytes in Solidity represents a dynamic array of bytes. 
     It’s a shorthand for byte[] .
    */
    bytes1 a = 0xb5;
    bytes1 b = 0x56;

    // Default values
    // Unassigned variables have a default value

    bool public defaultBoo;
    uint public defaultUint;
    int public defaultInt;
    address public defaultAddr;

}