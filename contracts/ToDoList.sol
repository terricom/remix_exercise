//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ToDoList {
// 定義一個 task struct，包含 name 以及 completed
// 定義一個 create()，可以新增 task
// 定義一個 update()，可以修改 task completed 狀態
// 定義一個 get()，可以輸入 index，查詢 task name & completed 狀態
// 定義一個 kill()，可以砍掉 contract
// 思考 access control，寫出不同版本
// 如果只想自己用，可以怎麼預防別人呼叫？
// 如果要讓大家使用，每個人記錄自己的 task，可以怎麼設計？
// 觀察原本的 gas 消耗狀況，改寫成更省 gas 的版本

    constructor() payable {}

    struct Task {
        string name;
        bool completed;
    }

    Task[] tasks;

    function create(string calldata name, bool completed) public {
        tasks.push(Task(name, completed));
    }

    modifier checkIndex(uint index) {
        require(index < tasks.length);
        _;
    }

    function update(uint index, bool completed) public checkIndex(index) {
        tasks[index].completed = completed;
    }

    function get(uint index) public view checkIndex(index) returns(string memory name, bool completed) {
        Task memory task = tasks[index];
        return (task.name, task.completed);
    }

    function kill() external {
        selfdestruct(payable(msg.sender));
    }
}