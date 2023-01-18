// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;

    // this special function is triggered when transaction is sent to this smart contract 
    // but no data is associated with the transaction
    receive() external payable {
        result = 1;
    }

    // when data is sent with transaction 
    fallback() external payable {
        result = 2;
    }
    // Ether is sent to contract
    //             is msg.data empty?
    //              /         \
    //            yes          no
    //            /              \
    //        receive()?       fallback()
    //         /     \
    //       yes      no
    //       /          \
    //  receive()    fallback()
}