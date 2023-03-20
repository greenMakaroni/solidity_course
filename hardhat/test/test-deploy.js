const { ethers } = require("hardhat")
const { expect, assert } = require("chai")

describe("SimpleStorage", () => {

  let SimpleStorageFactory, simpleStorage;

  beforeEach( async () => {
    SimpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
    simpleStorage = await SimpleStorageFactory.deploy()
  })

  it("Deployed simple storage contract should start with favorite number equal to 0", async () => {
    const currentValue = await simpleStorage.retrieve()
    const expectedValue = "0"
    // assert or expect

    assert.equal(currentValue.toString(), expectedValue)
  })

  it("favorite number should update when we call store", async () => {
    await simpleStorage.store("699")

    const updatedValue = await simpleStorage.retrieve()
    const expectedValue = "699"

    assert.equal(updatedValue.toString(), expectedValue)
  })

  it("Should add a person to people array", async () => {

    await simpleStorage.addPerson("Lmao", 15)
    const person = await simpleStorage.people(0)
    const expected = "15,Lmao"

    assert.equal(person.toString(), expected)

  })

  it("Should retrieve favorite number", async () => {
    const expected = "0"
    const retrieved = await simpleStorage.retrieve()

    assert.equal(retrieved.toString(), expected)
  })
})

// we can run specific test by using
// npx hardhat test --grep favorite number should update when we call store

// or using it.only