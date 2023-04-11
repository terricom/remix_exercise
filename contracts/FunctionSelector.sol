//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FunctionSelector {
    // 只要輸入 "function name + paremeter types，不用 paremeter names 和參數間的空格"
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}

contract Receiver {
    event Log(bytes data);

    function transfer(address _to, uint _amount) external {
        emit Log(msg.data);
        // 0xa9059cbb
        // 000000000000000000000000ab8483f64d9c6d1ecf9b849ae677dd3315835cb2
        // 000000000000000000000000000000000000000000000000000000000000000b
    }
}