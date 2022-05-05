// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./Import.sol";

import { Unauthorized, add as func, Point} from "./Import.sol";

contract F {
    Foo public impo = new Foo();

    function getImpoName() public view returns (string memory) {
        return impo.name();
    }
}