//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Errors {
    function testRequire(uint _i) public pure {
        require(_i <= 10, "_i > 10");
    }

    function testRevert(uint _i) public pure {
        if (_i > 10) {
            revert("_i > 10");
        }
    }

    uint public num = 123;

    function testAssert() public view {
        assert(num == 123);
    }

    function foo(uint _i) public {
        num += 1;
        require(_i < 10);
    }

    error MyError(address caller, uint i);

    function testCustomError(uint _i) public view {
        if (_i > 10) {
            revert MyError(msg.sender, _i);
        }
    }
}