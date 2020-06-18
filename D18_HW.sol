// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol';

contract Main {
    using SafeMath for uint256;
    
    function div(uint256 l, uint256 r) public pure returns (uint256) {
        return l.div(r);
    }
}
