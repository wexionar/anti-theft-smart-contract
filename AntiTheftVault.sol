// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
* @title Anti-Theft Smart Contract
* @dev High-security vault with hidden sentinels and mandatory time-locks.
* * Developers:
* - Alex
* - Gemini
*/
contract AntiTheftVault {
    
    address public owner;
    address public recoveryAddress; // The "Cold Bunker"
    
    // Privacy: Only the hashes are stored. Sentinels remain invisible.
    bytes32[] private sentinelHashes;
    uint256 public constant VETO_THRESHOLD = 2; 
    uint256 public constant LOCK_TIME = 48 hours;

    struct WithdrawalRequest {
        address target;
        uint256 amount;
        uint256 releaseTime;
        uint256 vetoCount;
        bool executed;
        bool cancelled;
    }

    mapping(uint256 => WithdrawalRequest) public requests;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    uint256 public requestCount;

    event WithdrawalRequested(uint256 indexed id, address indexed target, uint256 amount, uint256 releaseTime);
    event VetoTriggered(uint256 indexed id, address indexed sentinel);
    event VaultEvacuated(address indexed recoveryTarget, uint256 totalAmount);

    constructor(address _recoveryAddress, bytes32[] memory _sentinelHashes) {
        owner = msg.sender;
        recoveryAddress = _recoveryAddress;
        sentinelHashes = _sentinelHashes;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized: Owner only");
        _;
    }

    function requestWithdrawal(address _target, uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient vault balance");
        
        requestCount++;
        requests[requestCount] = WithdrawalRequest({
            target: _target,
            amount: _amount,
            releaseTime: block.timestamp + LOCK_TIME,
            vetoCount: 0,
            executed: false,
            cancelled: false
        });

        emit WithdrawalRequested(requestCount, _target, _amount, block.timestamp + LOCK_TIME);
    }

    function vetoTransaction(uint256 _requestId) external {
        require(!requests[_requestId].executed, "Transaction already executed");
        require(!requests[_requestId].cancelled, "Transaction already cancelled");
        require(!hasVoted[_requestId][msg.sender], "Sentinel already voted");

        bytes32 senderHash = keccak256(abi.encodePacked(msg.sender));
        bool isSentinel = false;
        for (uint i = 0; i < sentinelHashes.length; i++) {
            if (sentinelHashes[i] == senderHash) {
                isSentinel = true;
                break;
            }
        }
        require(isSentinel, "Access denied: Not a sentinel");

        hasVoted[_requestId][msg.sender] = true;
        requests[_requestId].vetoCount++;
        emit VetoTriggered(_requestId, msg.sender);

        if (requests[_requestId].vetoCount >= VETO_THRESHOLD) {
            evacuateVault();
        }
    }

    function evacuateVault() private {
        uint256 balance = address(this).balance;
        (bool success, ) = payable(recoveryAddress).call{value: balance}("");
        require(success, "Evacuation failed");
        emit VaultEvacuated(recoveryAddress, balance);
    }

    function completeWithdrawal(uint256 _requestId) external onlyOwner {
        WithdrawalRequest storage request = requests[_requestId];
        require(block.timestamp >= request.releaseTime, "Time-lock active");
        require(!request.executed, "Already executed");
        require(!request.cancelled, "Request was vetoed/cancelled");

        request.executed = true;
        (bool success, ) = payable(request.target).call{value: request.amount}("");
        require(success, "Transfer failed");
    }

    receive() external payable {}
}
