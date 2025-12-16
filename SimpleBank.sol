pragma solidity ^0.8.0;
contract SimpleBank{
    mapping(address => uint256) private balances;
    mapping(address => bool) private enrolled;

    address public owner;
    // Events
    event Enrolled(address accountAddress, uint256 amount);
    event WithdrawalMade(address accountAddress, uint256 amount);

    constructor(){
        owner = msg.sender;
    }

    //Enroll a new user
    function enroll() public {
        require(!enrolled[msg.sender],"Already enrolled");
        enrolled[msg.sender] = true;
        balances[msg.sender] = 0;
        emit Enrolled(msg.sender);
    }
    // Deposit ETH
    function deposit() public returns(uint256){
        require(enrolled[msg.sender], "Not enrolled yet");
        balances[msg.sender]+=msg.value;
        emit DepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }
    
    function withdraw(uint256 withdrawAmount) public returns (uint256){
        require(enrolled[msg.sender], "Not enrolled yet");
        require(balances[msg.sender] >= withdrawAmount, "Insufficient balance);
        balances[msg.sender] -=withdrawAmount;
        payable(msg.sender).transfer(withdrawAmount);
        return balances[msg.sender];
    }

    //Check balance
    function getBalance() public view returns (uint256){
        require(enrolled[msg.sender], "Not enrolled yet);
        return balances[msg.sender];
    }
    //Transfer ETH to another enrolled user
    function transfer(address to, uint256 amount) public{
        require(enrolled[msg.sender],"Sender not enrolled");
        require(enrolled[to],"Recipient not enrolled");
        require(balances[msg.sender]>=amount,"Insufficient balance");

        balances[msg.sender]-=amount;
        balances[to]+=amount;

        emit DepositMade(to, amount);
        emit WithdrawalMade(msg.sender, amount);
    }
}
