pragma solidity ^0.8.0;

contract SimpleAuction{
    address public owner;
    uint public highestBidAmount;
    address public highestBidder;
    bool public bidEnded; 

    mapping(address => uint) public pendingReturns;

    constructor() {
        owner = msg.sender;
    }

    function bid() public payable{
        require(!bidEnded, "bid ended.. ");
        require(msg.value > highestBidAmount, "bid too low!");

        if (highestBidAmount>0){
            pendingReturns[msg.sender]+=highestBidAmount;
        }
        highestBidder = msg.sender;
        highestBidAmount = msg.value;
    }

    function withdraw() public {
        uint amount = pendingReturns[msg.sender];
        require(amount > 0, "No funds to withdraw");

        pendingReturns[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }


    function endBid() public{
        require(msg.sender == owner, "only owner can send the bid");
        require(!bidEnded, "bid already ended..");
        bidEnded = true;
        payable(owner).transfer(highestBidAmount);
    } 

}

