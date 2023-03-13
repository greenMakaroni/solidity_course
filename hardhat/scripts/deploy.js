//imports
const { ethers, run, network } = require("hardhat")

async function main() {
  const SimpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
  console.log("Deploying contract...")
  const simpleStorage = await SimpleStorageFactory.deploy()
  await simpleStorage.deployed()

  console.log(`Contract deployed to ${simpleStorage.address}`)
  console.log(`Network config: `, network.config)

  if(network.config.chainId != 1337 && process.env.ETHERSCAN_API_KEY) {
    await simpleStorage.deployTransaction.wait(7);
    await verify(simpleStorage.address, []);
  }

}

async function verify(contractAddress, args) {
  console.log("Verifying contract...")
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    })
  } catch (e) {
    console.log(e)
  }
}

main().then(() => process.exit(0)).catch((error) => {
  console.log(error)
  process.exit(1)
})