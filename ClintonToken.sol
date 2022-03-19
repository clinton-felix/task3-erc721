// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.5.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.5.0/access/Ownable.sol";

contract ClintonToken is ERC20, Ownable {

    uint256 public tokensPerEther = 1000 * 10 ** decimals();

    constructor() ERC20("ClintonToken", "CLT") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function buyToken(address receiver, uint256 amount) public payable {
        amount = msg.value * tokensPerEther;
        require (balanceOf(owner()) >= amount, "not enough tokens");
        _transfer(owner(), receiver, amount);
        emit Transfer(owner(), receiver, amount);

        payable(owner()).transfer(msg.value);
    }
}
