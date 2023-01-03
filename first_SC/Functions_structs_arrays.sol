// SPDX-License-Identifier: MIT
 pragma solidity 0.8.8;

contract SimpleStorage {
    // EVM can access and store information in six places:

    // 1 Stack
    // 2 Memory
    // 3 Storage 
    // 4 Calldata
    // 5 Code
    // 6 Logs

    // calldata and memory means that variable exists only temporarly, duing the transaction when the function is called
    // storage variable will exist outside, even after transaction execution
    // without specifying, the variables are by default put into storage
    // calldata is temporary and cannot be modified
    // memory is temporary and can be modified
    // storage is permament variables that can be modified

    // arrays, structs and mappings are special. We need to tell solidity the data location of array, stucts and mappings
    // string is an array of bytes. 

    struct People {
         string name; 
         uint256 favoriteNumber; 
     }

    People[] public people;
    
    // mapping is like a dictionary
    mapping(string => uint256) public nameToFavNumber;

     function addPerson(string memory _name, uint256 _favoriteNumber) public{
         People memory anotherPerson = People({name: _name, favoriteNumber: _favoriteNumber});
         people.push(anotherPerson);

         // adding entry to a dictionary // key _name has value _favoriteNumber
         nameToFavNumber[_name] = _favoriteNumber;
         
    }

}