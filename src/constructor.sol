// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

//there are two ways to initialize parent contract with parameters

//pass the parameters here in the inheritance list
contract B is X("input to x"), Y("input to Y") {

}

contract C is X, Y {
    //pass the parameters here in the constructor
    //similar to function modifier
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}

}

//parent constructors are always called in the order of inheritance
//regardless of the order of parent contracts listed in the constructor
//of the child contract

//order of constructors called
//1. X
//2. Y
//3. D

contract D is X, Y {
    constructor() X("x was called") Y("y was called") {}
}


