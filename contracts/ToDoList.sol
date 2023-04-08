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

    mapping(bytes32 => mapping(address => bool)) public roles;

    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    constructor() payable {}

    struct Task {
        string name;
        bool completed;
    }

    Task[] tasks;

    function create(string calldata name, bool completed) public onlyRole(ADMIN) ownerOnly {
        tasks.push(Task(name, completed));
    }

    modifier checkIndex(uint index) {
        require(index < tasks.length);
        _;
    }

    function update(uint index, bool completed) public checkIndex(index) onlyRole(ADMIN) ownerOnly {
        tasks[index].completed = completed;
    }

    function get(uint index) public view checkIndex(index) onlyRole(ADMIN) ownerOnly returns(string memory name, bool completed) {
        Task memory task = tasks[index];
        return (task.name, task.completed);
    }

    modifier ownerOnly() {
        require(msg.sender == tx.origin);
        _;
    }

    function kill() external ownerOnly {
        selfdestruct(payable(tx.origin));
    }

    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender], "not authorized");
        _;
    }

    function grantRole(bytes32 _role, address _account) external onlyRole(ADMIN) ownerOnly {
        roles[_role][_account] = true;
    }

    function revokeRole(bytes32 _role, address _account) external onlyRole(ADMIN) ownerOnly {
        roles[_role][_account] = false;
    }
}