// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract HelloWorld {
    string public message = "Hello, World!";

    function setMessage(string memory _msg) public {
        message = _msg;
    }
}
