// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// external contract used for try / catch examples
contract Foo {
    address public owner;

    constructor(address _owner) {
        require(_owner != address(0), "invalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }

    function myFunc(uint x) public pure returns (string memory) {
        require(x != 0, "require failed");
        return "my func was called";
    }
}

contract Bar {
    event Log(string message );
    event LogBytes(bytes data);

    Foo public foo;

    constructor() {
        // this foo contract is used for example of try catch with external call
        foo = new Foo(msg.sender);
    }

    function trycatchcall(uint _i) public {
        try foo.myFunc(_i) returns (string memory result) {
            emit Log(result);
        } catch {
            emit Log("external call failed");
        }
    }

    function trycatchnewcontract(address _owner) public {
        try new Foo(_owner) returns (Foo foo) {
            emit Log("foo created");
        } catch Error(string memory reason) {
            // catch failing revert() and require()
            emit Log(reason);
        } catch (bytes memory reason) {
            emit LogBytes((reason));
        }
    }
}