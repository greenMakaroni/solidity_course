require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()

const ganache_url = process.env.GANACHE_URL;
const pk = process.env.PRIVATE_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    ganache: {
      url: ganache_url,
      accounts: [pk],
      chainId: 1337
    }
  },
  solidity: "0.8.18",
};
