// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./Token.sol";
import "hardhat/console.sol";

contract Lock {
    YtuToken Token;
    uint256 public lockerCount; 
    uint256 public totalLocked;
    mapping (address => uint256) public lockers;
    mapping (address => uint256)public deadline;


    constructor(address tokenaAddress){
        Token = YtuToken(tokenaAddress);
    }
    
    function lockTokens(uint256 amount,uint256 time) external {
        require(amount > 0,"Token amount must be greater than 0");
        require(time > 0,"Locking time must be greater than 0");

        // require(Token.balanceOf(msg.sender) >= amount,"Insufficient amount"); // ERC20 zaten bunları sağlıyor o yüzden yazmamıza gerek yok
        // require(Token.allowance(msg.sender, address(this));(msg.sender) >= amount,"Insufficient amount");
        if(!(lockers[msg.sender] > 0))
            lockerCount++;
        totalLocked += amount;
        lockers[msg.sender] += amount;
        deadline[msg.sender] = block.timestamp + time;
 
        bool ok = Token.transferFrom(msg.sender, address(this), amount);
        require(ok,"Transfer failed.");
    }

    function withdrawTokens() external {
        require(lockers[msg.sender] > 0,"Token amount is 0");
        require(block.timestamp >= deadline[msg.sender],"Deadline is not over");
        uint256 amount = lockers[msg.sender];
        console.log("amount ve address",amount,msg.sender);
        delete(lockers[msg.sender]);
        delete(deadline[msg.sender]);

        lockerCount--;
        totalLocked -= amount;
        require(Token.transfer(msg.sender,amount),"Transfer failed.");
    }


}