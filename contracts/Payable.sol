//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Payable {
    // payable address 可以接收 Eth
    address payable public owner;

    // payable constructor 可以接收 Eth
    constructor() payable {
        owner = payable(msg.sender);
    }

    // 接收 Eth 的方法，在 call 方法時在 value 帶上 Eth 會增加合約的 balance
    function deposit() external payable {}

    // 沒有帶 payable 的方法不能接收 Eth
    function notPayable() external {}

    // 回傳合約的 balance
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}