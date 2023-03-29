//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Order of inheritance - most base like to be derived

/*
        X
    Y       A
    |       |
    |       B
        Z
    
 order: X, Y, A, B, Z
*/

contract X {
    function foo() public pure virtual returns (string memory) {
        return "X";
    }

    function bar() public pure virtual returns (string memory) {
        return "X";
    }

    function x() public pure returns (string memory) {
        return "X";
    }
}

contract Y is X {
    function foo() public pure virtual override returns (string memory) {
        return "X";
    }

    function bar() public pure virtual override returns (string memory) {
        return "X";
    }

    function y() public pure returns (string memory) {
        return "Y";
    }
}

contract Z is X, Y {
    function foo() public pure virtual override(X, Y) returns (string memory) {
        return "Z";
    }

    function bar() public pure virtual override(X, Y) returns (string memory) {
        return "Z";
    }

}