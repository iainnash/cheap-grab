// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ExecuteCommandsTypes} from "./ExecuteCommandsTypes.sol";

contract Grabber is ExecuteCommandsTypes {
    error FailedCommand(bytes error, address target, uint256 value, bytes data);
    error TransferFailed(address recipient, uint256 amount);

    event Success(
        address indexed recipient,
        uint256 indexed amount,
        Command[] commands
    );

    function execute(
        address target,
        uint256 value,
        bytes calldata data
    ) external {
        (bool success, bytes memory ret) = target.call{value: value}(data);
        if (!success) {
            revert FailedCommand(ret, target, value, data);
        }
    }

    function rm(address recipient) external {
        assembly {
            selfdestruct(recipient)
        }
    }
}
