//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe {
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

    //function withdraw(){}
}