//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ViewAndPureFunctions {
    uint public num;

    function viewFunc() external view returns (uint) {
        return num; // 存取 state variable
    }

    function pureFunc() external pure returns (uint) {
        return 1; // 沒有存取任何 state variable
    }

    function addToNum(uint x) external view returns (uint) {
        return num + x; // 存取 state variable 並計算
    }

    function add(uint x, uint y) external pure returns (uint) {
        return x + y; // 沒有存取任何 state variable 的計算
    }
}