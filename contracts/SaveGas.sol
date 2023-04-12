//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// 越少存取 state variable，越省 Gas fee
contract SaveGas {
    uint public n = 5;

    // 4864 gas
    function noCache() external view returns (uint) {
        uint s = 0;
        for (uint i = 0; i < n; i++) {
            s += 1;
        }
        return s;
    }

    // 4355 gas
    function cache() external view returns (uint) {
        uint s = 0;
        uint _n = n;
        for (uint i = 0; i < _n; i++) {
            s += 1;
        }
        return s;
    }
}