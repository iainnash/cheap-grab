// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Create2} from "./Create2.sol";
import {Grabber} from "./Grabber.sol";
import {ExecuteCommandsTypes} from "./ExecuteCommandsTypes.sol";

contract CheapGrab is ExecuteCommandsTypes {
    function _salt(address owner) internal pure returns (bytes32) {
        return keccak256(abi.encode(owner));
    }

    function getGrabAddress(address owner) external view returns (address) {
        return
            Create2.computeAddress(
                _salt(owner),
                keccak256(type(Grabber).creationCode)
            );
    }

    function grab(Command[] calldata commands) external {
        address owner = msg.sender;
        address deployed = Create2.deploy(0, _salt(owner), type(Grabber).creationCode);
        Grabber grabber = Grabber(deployed);
        for (uint256 i = 0; i < commands.length; ++i) {
            grabber.execute(commands[i].target, commands[i].value, commands[i].data);
        }
        grabber.rm(owner); 
    }
}
