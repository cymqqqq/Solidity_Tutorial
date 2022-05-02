// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Gas {
    uint public i = 0;

    //using upa all of the gas that you send causes your transaction to fail
    //state changes are undone
    //gas spent are not defined
    function forever() public {
        //here we run a loop until all of the gas are spent
        //and the transaction fails
        while (true) {
            i += 1;
        }
    }
}