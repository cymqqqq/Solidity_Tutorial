
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Function {
    // functions can return multiple values
    function returnMany()
        public
        pure
        returns (
            uint,
            bool,
            uint
        )
    {
        return (1, true, 2);
    }

    //return values can be named
    function named() 
        public
        pure
        returns (
            uint x,
            bool b,
            uint y
        )
    {  
        return (1, true, 2);
    }

    //return values can be assigned to their name.
    //in this case the return statement can be omitted
    function assigned()
        public
        pure 
        returns(
            uint x,
            bool b,
            uint y
        ) {
            x = 1;
            b = true;
            y = 2;
        }

        //use destructing assignment when calling another
        //function that returns multiple values
        function destructuringAssignments()
            public
            pure 
            returns (
                uint,
                bool,
                uint,
                uint,
                uint
            ) {
                (uint i, bool b, uint j) = returnMany();

                //values ccan be left out
                (uint x, , uint y) = (4, 5, 6);

                return (i, b, j, x, y);
            }

        //cannot use map for either input or output
        //can use array for input
        function arrayinput(uint[] memory _arr) public {}

        //can use array for output
        uint[] public arr;

        function arrayoutput() public view returns (uint[] memory) {
            return arr;
        }

}