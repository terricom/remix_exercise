//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
    public - any contract and account can call
    private - only inside the contract that defines the function
    internal- only inside contract that inherits an internal function
    external - only other contracts and accounts can call

    Note: State variables can be declared as public, private, or internal but not external.

    contract A {
        private pri()
        internal inter()
        public pub()        <------ C
        external ext()      <------ pub() and ext()
    }

    contract B is A {
        inter()             <----- C
        pub()               <----- pub() and ext()
    }
*/

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;
    
    function privateFunc() private pure returns (uint) {
        return 0;
    }

    function internalFunc() internal pure returns (uint) {
        return 100;
    }

    function publicFunc() public pure returns (uint) {
        return 200;
    }

    function externalFunc() external pure returns (uint) {
        return 300;
    }

    function examples() external view {
        x + y + z; // 3

        privateFunc(); // 0
        internalFunc(); // 100
        publicFunc(); // 200

        this.externalFunc(); // 要用 this.functionName 才能調用 external，多此一舉且消耗更多 gas
    }
}

contract VisibilityChild is VisibilityBase {
    function example2() external view {
        y + z; // 3
        internalFunc(); // 100
        publicFunc(); // 200
    }
}