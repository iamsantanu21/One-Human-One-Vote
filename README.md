# 🗳️ One-Human-One-Vote: ZK-Verified Anonymous Voting

> A privacy-preserving decentralized voting application built at **IIT Madras Hackathon**

[![Solidity](https://img.shields.io/badge/Solidity-^0.8.20-363636?logo=solidity)](https://soliditylang.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## 📋 Problem Statement

Traditional on-chain voting systems face critical privacy challenges:
- **Identity Exposure**: Voter addresses are publicly visible on the blockchain
- **Centralized Trust**: Systems rely on centralized whitelists managed by trusted parties
- **Linkability**: Votes can be traced back to individual voters

### Our Solution

Build a **zero-knowledge (ZK) voting dApp** where eligibility is privately provable via ZK proofs, ensuring **one-human-one-vote anonymity** without revealing who voted for what.

---

## ✨ Features

- 🔐 **Anonymous Voting**: Cast votes without revealing voter identity
- 🌳 **Merkle Tree Eligibility**: Off-chain eligibility list committed as Merkle root on-chain
- 🛡️ **ZK Proofs**: Prove membership + nullifier ("I'm eligible AND haven't voted")
- 📊 **Transparent Tallies**: View aggregated results without individual vote linkage
- 🖥️ **User-Friendly Frontend**: Simple interface for voters and organizers

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         FRONTEND                                │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐   │
│  │  Verification   │ │     Voting      │ │     Results     │   │
│  │     Page        │ │      Page       │ │      Page       │   │
│  └────────┬────────┘ └────────┬────────┘ └────────┬────────┘   │
└───────────┼───────────────────┼───────────────────┼─────────────┘
            │                   │                   │
            ▼                   ▼                   ▼
┌─────────────────────────────────────────────────────────────────┐
│                     SMART CONTRACTS                             │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              FastExponentiation.sol                      │   │
│  │         (Modular exponentiation for ZK proofs)          │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │  • Merkle Root Storage (Eligibility List)               │   │
│  │  • Nullifier Registry (Prevent Double Voting)           │   │
│  │  • Vote Tally Storage (A/B/C Choices)                   │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📁 Project Structure

```
IITM_Hackathon/
├── README.md                          # Project documentation
├── Solidity/
│   └── FastExponentiation.sol         # Fast modular exponentiation contract
└── frontend/
    ├── verification_page.html         # ZK proof generation & eligibility check
    ├── voting_page.html               # Anonymous vote casting interface
    └── result_page.html               # Vote tally visualization
```

---

## 🔧 Smart Contracts

### FastExponentiation.sol

Implements **modular exponentiation** using the square-and-multiply algorithm:

```
(base ^ exponent) mod p
```

This is a core cryptographic primitive used in:
- **ZK proof generation**: Computing commitments and challenges
- **Nullifier derivation**: Ensuring unique vote identifiers
- **Signature verification**: Validating voter credentials

**Key Features:**
- Gas-efficient binary exponentiation
- O(log n) complexity for exponent of n bits
- Pure function (no state changes)

---

## 🔐 How ZK Voting Works

### 1. Setup Phase (Organizer)
```
1. Compile eligibility list (addresses/hashed IDs)
2. Build Merkle tree from eligible voters
3. Publish Merkle root on-chain
```

### 2. Voting Phase (Voter)
```
1. Generate ZK proof proving:
   ├── "I am in the eligibility tree" (Merkle membership)
   └── "I haven't voted before" (unique nullifier)
2. Submit proof + encrypted vote to smart contract
3. Contract verifies proof and records vote
```

### 3. Tallying Phase
```
1. Aggregate all valid votes
2. Display results (A/B/C counts)
3. No individual votes are linkable to voters
```

---

## 🚀 Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (v16+)
- [MetaMask](https://metamask.io/) or compatible Web3 wallet
- [Hardhat](https://hardhat.org/) or [Foundry](https://getfoundry.sh/) for contract deployment

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/IITM_Hackathon.git
cd IITM_Hackathon

# Install dependencies (if package.json exists)
npm install
```

### Deploy Contracts

```bash
# Using Hardhat
npx hardhat compile
npx hardhat deploy --network <network-name>

# Or using Foundry
forge build
forge deploy
```

### Run Frontend

```bash
# Serve the frontend locally
npx serve frontend
# Or use any static file server
python -m http.server 8080 --directory frontend
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| **Smart Contracts** | Solidity ^0.8.20 |
| **Blockchain** | Ethereum / EVM Compatible |
| **ZK Proofs** | Merkle Trees + Nullifiers |
| **Frontend** | HTML/CSS/JavaScript |
| **Wallet** | MetaMask / Web3 |

---

## 📊 Vote Flow Diagram

```
Voter                    Smart Contract              Organizer
  │                            │                          │
  │  1. Get Merkle Proof       │                          │
  │ ◄──────────────────────────┼──────────────────────────┤
  │                            │                          │
  │  2. Generate ZK Proof      │                          │
  │  (membership + nullifier)  │                          │
  │                            │                          │
  │  3. Submit Vote + Proof    │                          │
  │ ──────────────────────────►│                          │
  │                            │                          │
  │                            │  4. Verify Proof         │
  │                            │  5. Check Nullifier      │
  │                            │  6. Record Vote          │
  │                            │                          │
  │  7. Vote Confirmed         │                          │
  │ ◄──────────────────────────│                          │
  │                            │                          │
  │                            │  8. View Results         │
  │                            │ ─────────────────────────►
```

---

## 👥 Team

This project was developed collaboratively during the Hackathon on Winter School on Decentralized Trust and Blockchains, 2025 (CyStar, CSE, IIT Madras).
By -  Santanu Mondal, Belina V, Shambhavi Gantla, Priya Kumari, Tingku Eusibious N Sangma, Amalan Joseph Antony A

---

## 🔮 Future Improvements

- [ ] Complete frontend implementation with Web3 integration
- [ ] Add SNARKs/STARKs for more efficient ZK proofs
- [ ] Implement on-chain Merkle tree verification
- [ ] Add support for multiple concurrent elections
- [ ] Mobile-responsive UI
- [ ] Integration with decentralized identity (DID) systems

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- IIT Madras CyStar for hosting the hackathon in Winter School


---

<p align="center">
  <b>🗳️ Vote Anonymously. Vote Securely. Vote Once.</b>
</p>
