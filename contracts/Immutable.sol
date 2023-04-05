//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Immutable {
    // 24648 gas
    // address public owner = msg.sender;

    // 22515 gas
    address public immutable owner; // immutable 在 init 時就要宣告，可以直接宣告或是寫在 constructor

    constructor() {
        owner = msg.sender;
    }

    uint public x;

    function foo() external {
        require(owner == msg.sender);
        x += 1;
    }
}