//SPDX-License-identifier: MIT

pragma solidity ^0.8.9;

contract TrustContract { //all we need in this contract
    address public father;
    address public child;
    uint256 public birthday;
    uint256 public withdrawalAge;
    uint256 public amount;

    constructor(address _child, uint256 _birthday) {
        father = msg.sender; // the Father is the one authorised to deploy the contract
        child = _child; // the child is the receiver
        birthday = _birthday; //the child's birthday, so we can verify
        withdrawalAge = 18; // the age meant for witdrawal
        
    }
    function withdraw(uint256 _amount) external {
        require(msg.sender == child, "Only the child can withdraw funds"); //made, so that only the child has access to withdraw funds incase of fraudsters
        require(block.timestamp >= birthday + withdrawalAge * 1, "The child is not eligible to withdraw yet");
        require(_amount <= amount, "Insufficient balance");
        amount -= _amount;
        payable(child).transfer(_amount);
    }

    function deposit() external payable {
        require(msg.sender == father, "Only the father can deposit funds");
        amount += msg.value;
    }

    
}
