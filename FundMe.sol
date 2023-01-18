//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// initial deployment GAS cost = 900,855 
// deployment GAS cost after appending minimumUSD price with constant keyword = 881,548 
// GAS cost after appending owner with immutable keyword = 858,669 

import "./PriceConverter.sol";

// declare custom error
error NotOwner();

contract FundMe {

    // variable determining ownership of the contract
    // typically convention is to append immutable variable with i_
    // instead of storage, we're saving it directly into the bytecode of the contract
    address public immutable i_owner;

    // it works like in any other programming language, it'll run immediately when contract is deployed
    constructor() {
        i_owner = msg.sender;
    }

    using PriceConverter for uint256;

    // constant keyword, no longer taking storage space
    // typical convention is to use app caps and underscores for constant variables
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Not enough ETH sent!"); // 1e18 = 1 * 10 ** 18  this equals 1 eth
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
        require(msg.sender == i_owner, "Sender is not owner!");
        // custom error for gas optimization
        // if(msg.sender != i_owner) {
        //     revert NotOwner();
        // }
        _;
        // underscore meand do the rest of the code in the function the modifier is used.
        // if the underscore was above require It'll do the function first and then require.
    }
    // What happens if someone sends this contract ETH without calling fund function?
    // The sender will not be appended to the array, the contract won't know who sent the money
    // there is way to execute some code when ETH is received
    // receive or fallback special functions
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

}