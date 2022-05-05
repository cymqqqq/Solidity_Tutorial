// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract A {
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo is called");
    }

    function bar() public virtual {
        emit Log("A.bar is called");
    }
}

contract B is A {
    function foo() public virtual override {
        emit Log("B.foo is called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("B.bar is called");
        super.bar();
    }
}

contract C is A {
    function foo() public virtual override {
        emit Log("C.foo is called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("C.bar is called");
        super.bar();
    }
}

contract D is B, C {
    function foo() public override(B, C) {
        super.foo();
    }

    function  bar() public override(B, C) {
        super.bar();
    }
}