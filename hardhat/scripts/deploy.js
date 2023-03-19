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

    // use 'retrieve' method defined in simpleStorage smart contract
    const currentValue = await simpleStorage.retrieve()
    console.log(`Current value: ${currentValue}`)
  
    // update current value of smart contract using store function defined in simpleStorage smart contract
    const transactionResponse = await simpleStorage.store(5)
    await transactionResponse.wait(1)
  
    const updatedValue = await simpleStorage.retrieve()
    console.log(`Updated value: ${updatedValue}`)

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