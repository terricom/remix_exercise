//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Function modifiers: 提取 func 在前、後段重複使用的邏輯
// 又分為下列三種：Basic-單獨一段沒有帶參數、Input-有帶參數、Sandwich-func執行前後

contract FunctionModifiers {
    bool public paused;
    uint public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }

    // Basic modifier
    modifier whenNotPaused() {
        require(!paused, "paused");
        _; // 繼續執行 func 的邏輯
    }

    function inc() external whenNotPaused {
        count += 1;
    }

    function dec() external whenNotPaused {
        count -= 1;
    }

    // Input modifier
    modifier cap(uint _x) {
        require(_x < 100, "_x >= 100");
        _;
    }

    function incBy(uint _x) external whenNotPaused cap(_x) {
        count += _x;
    }

    // Sandwich modifier
    modifier sandwich() {
        count += 10;
        _;
        count *= 2;
    }

    function foo() external whenNotPaused sandwich {
        count += 1;
        /*
        init            count = 0;
        sandwich(+10)   10;
        foo(+1)         11;
        sandwich(*2)    22;
        */
    }
}