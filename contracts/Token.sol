// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YtuToken is ERC20 {
    constructor() ERC20("Ytu Token","YTU"){
        _mint(msg.sender,1773000 * 10 ** decimals()); 
    }
}