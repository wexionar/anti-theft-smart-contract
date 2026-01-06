// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Sentinel Hasher Tool
 * @dev Use this to generate the bytes32 hashes for your sentinels privately.
 * Developers: Alex & Gemini
 */
contract SentinelHasher {
    /**
     * @dev Input the sentinel address to get the keccak256 hash.
     * Run this locally or in a private environment!
     */
    function generateHash(address _sentinel) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_sentinel));
    }
}
