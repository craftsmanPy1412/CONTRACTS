//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract escrow{
    address public buyer;
    address public seller;
    address public arbiter;

    enum State {AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE }
    State public state;
    
    constructor(
        address _seller,
        address _arbiter
    ){
    seller = _seller;
    arbiter = _arbiter;
    buyer = msg.sender;
    state = State.AWAITING_PAYMENT;
    }

    function depositEther() public payable{
        require(state == State.AWAITING_PAYMENT, "Already paid");
        require(msg.sender == buyer,"Only Buyer");
        require(msg.value>0,"No Ether");

        state = State.AWAITING_DELIVERY;

}

    function approveFunds() public{
        require(state == State.AWAITING_DELIVERY, "Invalid state!");
        require(msg.sender == buyer || msg.sender == arbiter);
        state = State.COMPLETE;
        uint amount = address(this).balance;
        (bool success, ) = seller.call{value: amount}("");
        require(success, "Transfer failed");        
    }

    function refundBuyer() public{
        require(state == State.AWAITING_DELIVERY,"Invalid state!");
        require(msg.sender == arbiter);
        state = State.COMPLETE;
        uint amount = address(this).balance;
        (bool success, ) = buyer.call{value: amount}("");
        require(success, "Refund failed");
}
}
