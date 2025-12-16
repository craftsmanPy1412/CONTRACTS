# Smart Contracts Collection

This repository contains a set of basic Ethereum smart contracts written for learning, experimentation, and reference purposes. The contracts are compiled and deployed using **Python scripts** (no JavaScript, no Hardhat), keeping the workflow simple and minimalistic. Each contract demonstrates a common blockchain use case using simple, readable logic.

## Contracts Included

### 1. Simple Bank

The **Simple Bank** contract simulates basic banking functionality on the blockchain.

**Key Features:**

* Deposit Ether into the contract
* Withdraw Ether from the contract
* Check account balance

**Purpose:**
To demonstrate secure handling of deposits, withdrawals, and user balances using smart contracts.

---

### 2. Bidding Contract

The **Bidding** contract implements a basic bidding/auction mechanism.

**Key Features:**

* Users can place bids using Ether
* Tracks the highest bidder and highest bid
* Prevents invalid or lower bids

**Purpose:**
To illustrate how auctions and competitive bidding can be implemented in a decentralized manner.

---

### 3. Lottery Contract

The **Lottery** contract represents a simple lottery system.

**Key Features:**

* Participants enter by sending Ether
* A random winner is selected
* Winner receives the total prize pool

**Purpose:**
To demonstrate participant management, randomness concepts, and fund distribution in smart contracts.

---

### 4. Escrow Contract

The **Escrow** contract enables secure transactions between a buyer and a seller with a trusted third party.

**Key Features:**

* Buyer deposits funds into escrow
* Funds are released to the seller upon approval
* Supports dispute resolution logic (if implemented)

**Purpose:**
To showcase trust-minimized transactions using conditional fund release.

---

## Technologies Used

* Solidity
* Python
* Web3.py
* solcx (Solidity compiler for Python)
* Ethereum Virtual Machine (E
  These contracts are intended for educational purposes only. They have not been audited and should not be used in production environments without proper security reviews.

## License

This project is open-source and available under the MIT License.
