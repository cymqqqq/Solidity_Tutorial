//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ArrayRemoveByShifting {
    uint[] public arr;

    function remove(uint _idx) public {
        require(_idx < arr.length, "index out of the bound");
        for (uint i = _idx; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        assert(arr[0] == 1);
        arr = [1];
        remove(0);
        
    }
}