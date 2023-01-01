// spdx license identifier its something you would wanna put at the top of the file
// it is optional but some compilers will throw errors
// it is to help with licensing, makes sharing code much easier
// declare it as so:

// SPDX-License-Identifier: MIT

 // declaring solidity version (required)
 pragma solidity 0.8.8;
// semicolon tells solidity its the end of the line

// pragma solidity ^0.8.18; the ^ operator tells solidity that any version from 0.8.18 "and above" is ok for this Smart Contract
// pragma solidity 0.8.18 means use only version 0.8.18
// pragma solidty >= 0.8.7 < 0.9.0 means greater or equal to 0.8.7 and smaller than 0.9.0

// this reserved keyword tells solidity that we're declaring a contract
contract SimpleStorage {

// primitive solidity data types.
// boolean = true or false,
// uint = positive integers,
// int = positive or negative integers
// address = an address, 
// bytes = 1 byte = 8 bits.

    bool hasFavNum = true;
    bool hasFavColor = false;

    // default uint size is 256, meaning it can store a number that can fit in 256 bits.
    uint favNum = 7;
    // but we can declare smaller uints.
    // uint8 will reserve 8 bits = 1 byte of space to hold a number.
    // similar with int
    int favNum2 = 7;
    // we can go only by the steps of 8.
    int16 favNum3 = 510;
    uint256 favNum4 = 1000;
    uint48 favNamba = 1;
    string favNum5 = "seven";
    address NotMyAddress = 0xa7bcec8bddFD1760f6Fa5219CaABE160e62Dc525;
    // bytes 32 is the maximum size bytes variable can be.
    bytes32 thirtyTwoBytesContainer = "doggo";
    // int256 lmao; is the same as int256 lmao = 0;

    // by default visibility of lmao is set to internal
    // we can modify visibility by adding public keyword to make it visible.
    uint256 public lmao;
    // four visibility modifiers, public, private, external and internal.
    // by declaring variable as public we're actually declaring a getter function for that variable.
    function changeLmao(uint256 _lmao) public {
        lmao = _lmao;
        lmao = lmao + 1;
    }

}
