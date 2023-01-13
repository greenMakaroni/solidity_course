//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe {

    // variable determining ownership of the contract
    address public owner;

    // it works like in any other programming language, it'll run immediately when contract is deployed
    constructor() {
        owner = msg.sender;
    }

    using PriceConverter for uint256;
    uint256 public minimumUSD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable{
        require(msg.value.getConversionRate() >= minimumUSD, "Not enough ETH sent!"); // 1e18 = 1 * 10 ** 18  this equals 1 eth
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
        // msg is globally available.

    }

    function withdraw() public onlyOwner {
        // only owner can withdraw.
        // require(msg.sender == owner); but instead we can create our own custom modifier keyword

        // solidity for loop
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) { 
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset funders array
        funders = new address[](0);
        // withdraw the funds

        // three different ways to sent Eth

        // transfer 
        payable(msg.sender).transfer(address(this).balance); // this contract's ballance
        // we're type casting msg.sender from address type to payable address type
        // issues with transfer
        // transfer is capped at 2300 GAS if more GAS is used it'll throw an error.

        // send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");
        // send is also capped at 2300 GAS but if more GAS is used instead of error it'll return boolean

        // call   // here it looks and works like es6 destructuring.
        // (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
        // call has no cap on GAS, returns bool
        // call is powerful, enables invoking any Eth function.

        // using call is prefered way of sending and receiving an Ethereum token.
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Sender is not owner!");
        _;
        // underscore meand do the rest of the code in the function the modifier is used.
        // if the underscore was above require It'll do the function first and then require.
    }

}