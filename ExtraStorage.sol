//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// Extra storage inherits from SimpleStorage
contract ExtraStorage is SimpleStorage {
    // override inherited functions using two keywords
    // virtual & override
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}