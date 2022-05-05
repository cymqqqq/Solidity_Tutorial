// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Base {
    //private function can only be called
    // inside this contract
    // contracts that inherit this contract cannot call this function
    function privateFunc() private pure returns (string memory) {
        return "private function called";
    }

    function testPrivateFunc() public pure returns (string memory) {
        return privateFunc();
    }

    // internal function can be called
    // inside the contract
    // inside contracts that inherit this contract
    function internalFunc() internal pure returns (string memory) {
        return "internal function called";
    }

    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }

    //public function can be called
    // inside this contract
    // inside contracts that inherit this contract
    // by other contracts and accounts
    function publicFunc() public pure returns (string memory) {
        return "public function called";
    }

    // external functions can only be called
    // by other contracts and accounts
    function externalFunc() external pure returns (string memory) {
        return "external function called";
    }

    //state variables
    string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    string public publicVar = "my public variable";

    //state variables cannot be external so this code won't compile.
    
}

contract Child is Base {
    // Inherited contracts do not have access to private functions
    //and state variables
    function testInternalFunc() public pure override returns (string memory) {
        return internalFunc();
    }
}