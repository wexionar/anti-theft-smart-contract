# Anti-Theft Smart Contract

## 🛡️ The Ultimate Security Layer for Digital Asset Custody

**Anti-Theft Smart Contract** is a high-security vault architecture designed to eliminate the risk of massive exchange hacks and private key compromises. While traditional multi-sig wallets fail when keys are stolen, this protocol implements a **reactive defense system** that grants owners the most valuable asset in security: **Time.**

---

## 🚨 The Problem: The "Hot Wallet" Vulnerability
Current institutional custody often relies on instant or semi-instant withdrawals. If a hot wallet's private keys are compromised (as seen in recent major exchange exploits), the funds are gone in seconds. There is no "undo" button in blockchain—until now.

## ✅ The Solution: A Sovereign Security Layer
This contract would have prevented such exploits by introducing a mandatory delay and a **hidden veto layer** that an attacker cannot anticipate, identify, or control.

---

## ✨ Key Features

### 1. 👥 Hidden Sentinels (Hashed Privacy)
The addresses of the guardians (Sentinels) are not visible on the contract. Only their **cryptographic hashes** are stored. 
* **The Benefit:** An attacker cannot know which wallets they need to compromise to bypass the security. The defense remains invisible until it is needed.

### 2. ⏳ Mandatory Time-Locks
Any withdrawal exceeding a predefined threshold is automatically placed in a "pending" state for a security period (e.g., 24-48 hours). 
* **The Benefit:** It eliminates the possibility of a "flash drain" of assets.

### 3. 🚫 The Veto Mechanism
During the time-lock period, any hidden Sentinel can broadcast a veto. 
* **The Benefit:** If a transaction is unauthorized, a Sentinel triggers the veto, cancels the transfer, and automatically triggers an **Emergency Evacuation** to a secure Recovery Address.

### 4. 📊 Threshold-Based Security
Small operational transfers remain fast for daily liquidity, while large, high-risk movements trigger the full security protocol.

---

## ⚠️ Critical Security Recommendation: The Recovery Address
For the "Protocol of Total Evacuation" to be effective, the **Recovery Address** (Cold Bunker) must follow these rules:
1. **Air-Gapped:** It must be a cold wallet (Hardware Wallet) that has never been exposed to any online environment.
2. **Recursive Security:** Ideally, the Recovery Address should be another instance of this same **Anti-Theft Smart Contract** with a different set of Sentinels. This creates a layered defense-in-depth architecture.

---

## ⚙️ How it Works

1. **Request:** The owner initiates a withdrawal.
2. **Evaluation:** If the amount exceeds the limit, the funds enter the **Vault-Lock**.
3. **Surveillance:** Sentinels monitor the blockchain for unauthorized requests.
4. **Execution or Veto:** * **If legitimate:** The owner completes the transfer after the time-lock expires.
    * **If malicious:** A Sentinel reveals themselves by executing a **Veto**, proving their identity against the stored hash and triggering the immediate evacuation of all funds to the secure búnker.

---

## 🛠 Technical Specifications
* **Language:** Solidity 0.8.x
* **Architecture:** Minimalist design to reduce the attack surface (Audit-Ready).
* **Efficiency:** Gas-optimized; sentinel verification only occurs during emergency vetoes.

---

## 👨‍💻 Developers
* **Alex**
* **Gemini**

---

## ⚖️ License
This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.
