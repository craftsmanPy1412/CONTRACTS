// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC20Token{
    string public name;
    string public symbol;
    uint public totalSupply;
    uint8 public decimals;
    address public owner;

    mapping(address => uint) private balances;

    event Transfer(address indexed from, address indexed to, uint value);
    constructor(string memory _name, string memory _symbol, uint _initSupply){
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        decimals = 18;

        totalSupply = _initSupply*(10**decimals);
        balances[owner] = totalSupply;
        emit Transfer(address(0), owner, totalSupply);
    }

    function balanceOf(address account) public view returns (uint){
        return balances[account];
    }
    function transfer(address to, uint amount) public returns(bool){
        require(to!=address(0),"Invalid Address");
        require(balances[msg.sender]>=amount, "not enough money!");
        balances[msg.sender]-=amount;
        balances[to]+=amount;
        emit Transfer(msg.sender, to, amount);

        return true;
    }
    



}
