//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SendEther {
    constructor() payable {}

    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable {
        // "gas": "2260"
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable {
        // "gas": "2260"
        bool sent = _to.send(123);
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable {
        // "gas": "6521"
        (bool success, ) = _to.call {value: 123}("");
        require(success, "call failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}