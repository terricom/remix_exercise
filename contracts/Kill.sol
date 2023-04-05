//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// selfdestruct
// - delete contract
// - force send ether to any address

contract Kill {

    constructor() payable {}

    // 把帳戶內的餘額轉給呼叫方
    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
}

contract Helper {
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function kill(Kill _kill) external {
        _kill.kill();
    }
}