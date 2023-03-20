require("@nomiclabs/hardhat-etherscan");
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()
require("./tasks/block-number")

// this hardhat plugin will give us all the info about gas usage
require("hardhat-gas-reporter")

// this hardhat plugin will check how many lines of code in our smart contract are not covered by tests
// to run: npx hardhat coverage
require("solidity-coverage")

const ganache_url = process.env.GANACHE_URL;
const pk = process.env.PRIVATE_KEY;
const etherscan_api_key = process.env.ETHERSCAN_API_KEY;

const localHardhat_url = process.env.LOCAL_HARDHAT_URL;
const localHardhat_pk = process.env.LOCALHARDHAT_PK;

const coinmarketcap_api_key = process.env.COIN_MARKET_CAP_API_KEY;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    ganache: {
      url: ganache_url,
      accounts: [pk],
      chainId: 1337
    },
    localHardhat: {
      url: localHardhat_url,
      accounts: [localHardhat_pk],
      chainId: 31337
    }
  },
  etherscan: {
    apiKey: etherscan_api_key
  },
  solidity: "0.8.18",
  gasReporter: {
    enabled: true,
    outputFile: "gas-report.txt",
    noColors: true,
    currency: "USD",
    coinmarketcap: coinmarketcap_api_key,
  }
};
