// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {
    address public manager;
    uint public minimumEntry;

    address[] public players;
    mapping(address => bool) public hasEntered;

    constructor(uint _minimumEntry) {
        manager = msg.sender;
        minimumEntry = _minimumEntry;
    }

    // Enter the lottery
    function enter() external payable {
        require(msg.value >= minimumEntry, "Insufficient ETH");
        require(!hasEntered[msg.sender], "Already entered");

        players.push(msg.sender);
        hasEntered[msg.sender] = true;
    }

    // Pick a winner (manager only)
    function pickWinner() external {
        require(msg.sender == manager, "Only manager");
        require(players.length > 0, "No players");

        uint index = randomIndex();
        address winner = players[index];

        uint amount = address(this).balance;
        (bool success, ) = winner.call{value: amount}("");
        require(success, "Transfer failed");

        // Reset lottery
        
        for (uint i = 0; i < players.length; i++) {
            hasEntered[players[i]] = false;
        }
        delete players;
    }

    // Pseudo-random index (for learning only)
    function randomIndex() internal view returns (uint) {
        return uint(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.prevrandao,
                    players.length
                )
            )
        ) % players.length;
    }

    // View helpers
    function getPlayersCount() external view returns (uint) {
        return players.length;
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
