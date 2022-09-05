// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./Token.sol";

contract Lock {
    YtuToken Token;
    uint256 public lockerCount; 
    uint256 public totalLocked;
    mapping (address => uint256) public lockers;


    constructor(address tokenaAddress){
        Token = YtuToken(tokenaAddress);
    }
    
    function lockTokens(uint256 amount) external {
        require(amount > 0,"Token amount must be greater than 0");

        // require(Token.balanceOf(msg.sender) >= amount,"Insufficient amount"); // ERC20 zaten bunları sağlıyor o yüzden yazmamıza gerek yok
        // require(Token.allowance(msg.sender, address(this));(msg.sender) >= amount,"Insufficient amount");
        if(!(lockers[msg.sender] > 0))
            lockerCount++;
        totalLocked += amount;
        lockers[msg.sender] += amount;

        bool ok = Token.transferFrom(msg.sender, address(this), amount);
        require(ok,"Transfer failed.");
    }

    function withdrawTokens() external {
        require(lockers[msg.sender] > 0,"Token amount is 0");
        uint256 amount = lockers[msg.sender];
        delete(lockers[msg.sender]);

        lockerCount--;
        totalLocked -= amount;
        require(Token.transfer(msg.sender,amount),"Transfer failed.");
    }


}