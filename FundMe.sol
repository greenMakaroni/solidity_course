//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// contract functionality:
// get funds from users
// withdraw funds
// set minimum funding value in USD

// importing contract interface from github repo
// enabling us to call functions defined in contract deployed on chainlink oracle network
// tbis contract returns price of ETH in USD as int
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// @chainlink/contracts is npm package, remix installs it

contract FundMe {
    uint256 public minimumUSD = 50 * 1e18;

    //payable keyword tells solidity that this function can be funded with eth
    function fund() public payable{
        require(getConversionRate(msg.value) >= minimumUSD, "Not enough ETH sent!"); // 1e18 = 1 * 10 ** 18  this equals 1 eth
        // if msg value is not greater than 1e18 then it will "revert"
        // meaning undo changes to the state of blockchain and return GAS
        // if gas is spent prior to reverting only remained amount of GAS is returned

    }

    function getPrice() public view returns(uint256) {
        // we're interracing with external contract, we need
        // ABI
        // Address 
        // Goerli test net ETH / USD Chainlink data feed // 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10); // 1 **10 == 10000000000
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        // in solidity, multiply and add first before division
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18; // without this, returned number would have additional 36 digits in it.
        return ethAmountInUSD;
    }

    //function withdraw(){}
}