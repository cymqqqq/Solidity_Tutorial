// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Enum {
    enum Status {
        Pending,
        Shpped,
        Accepted,
        Rejected,
        Cancled
    }

    //default value is the first element listed in
    //definition of the type, in this case "Pending"
    Status public status;

    function get() public view returns (Status) {
        return status;
    }

    //update status by passing uint into input
    function set(Status _status) public {
        status = _status;
    }

    //you can update to a specific enum like this
    function cancle() public {
        status = Status.Cancled;
    }

    //delete resets the enum to its first value, 0
    function reset() public {
        delete status;
    }
    
}