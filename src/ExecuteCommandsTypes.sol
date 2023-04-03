// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract ExecuteCommandsTypes {
    struct Command {
        address target;
        uint256 value;
        bytes data;
    }
}
