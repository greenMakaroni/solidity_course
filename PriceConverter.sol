//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// @chainlink/contracts is npm package, remix installs it

// no state variables or ether
library PriceConverter {
    
    function getPrice() internal view returns(uint256) {
        // we're interracing with external contract, we need
        // ABI
        // Address 
        // Goerli test net ETH / USD Chainlink data feed // 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10); // 1 **10 == 10000000000
    }

    function getVersion() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        // in solidity, multiply and add first before division
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18; // without this, returned number would have additional 36 digits in it.
        return ethAmountInUSD;
    }
}