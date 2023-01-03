 // SPDX-License-Identifier: MIT
 pragma solidity 0.8.8;

 contract More {
     // by adding public keyword to a variable
     // we're secretly adding a function that returns the value of that variable
     uint256 public favNum;

    // two keywords that notate when functions don't have to spend any gas when run "view" and "pure"
    // view - read state from the contract
    // pure - don't allow reading from the blockchain and modifications of state and 
     function getFavNum() public view returns(uint256) {
         return favNum;
     }

    // calling this function is free unless it is called inside other function that consumes gas.
     function add() public pure returns(uint256) {
         return(1 + 1);
     }

     // we can create our own data structures
     struct People {
         // variables in a struct and within contract block get automatically indexed
         string name; // i = 0
         uint256 favoriteNumber; // i = 1
     }

     People public person = People({name: "Dawid", favoriteNumber: 7});

     // arrays
     uint256[] public numbers;

     // empty brackets denote dynamic array, no limit on how many elements it can hold
     People[] public people;

     // [3] denotes that this array can hold only 3 people
     People[3] public three_people;

    // function of adding elements to array 
     function addPerson(string memory _name, uint256 _favoriteNumber) public{
         People memory anotherPerson = People({name: _name, favoriteNumber: _favoriteNumber});
         people.push(anotherPerson);

         // altermative
         // people.push(People(_name, _favoriteNumber));
     }
 }