//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ForAndWhileLoops {
    function loops() external pure {
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                continue; // i = 3 不會繼續跑下面的 code
            }
            if (i == 5) {
                break; // i = 5..9 不會繼續跑下面的 code
            }
        }

        uint j = 0;
        while (j < 10) {
            j ++;
        }
    }

    function sum(uint _n) external pure returns (uint) {
        uint s;
        for (uint i = 1; i <= _n; i ++) {   // _n = 3
            s += i;                         // s + 1 + 2 + 3 = 6
        }
        return s;                           // 6
    }
}