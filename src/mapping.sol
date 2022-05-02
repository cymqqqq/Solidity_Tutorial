// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Mapping {
    mapping(address => uint) public MyMap;

    function get(address _addr) public view returns (uint) {
        return MyMap[_addr];
    }

    function set(address _addr, uint num) public {
        MyMap[_addr] = num;
    }

    function remove(address _addr) public {
        delete MyMap[_addr];
    }
}

contract NestedMapping {
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr1, uint _i) public view returns (bool) {
        return nested[_addr1][_i];
    }

    function set(
        address _addr1,
        uint _i,
        bool _boo
    ) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr, uint _i) public {
        delete nested[_addr][_i];
    }
}