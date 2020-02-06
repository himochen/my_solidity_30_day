pragma solidity ^0.5.0;

import 'https://raw.githubusercontent.com/himochen/my_solidity_30_days/master/Ownable.sol';
import 'https://raw.githubusercontent.com/himochen/my_solidity_30_days/master/SafeMath.sol';

contract FallbackHack is Ownable {
  
  using SafeMath for uint256;
  mapping(address => uint) public contributions;

  constructor() public {
    contributions[msg.sender] = 1000 * (1 ether);
  }

  function contribute() public payable {
    require(msg.value < 0.001 ether);
    contributions[msg.sender] = contributions[msg.sender].add(msg.value);
    if(contributions[msg.sender] > contributions[owner]) {
      owner = msg.sender;
    }
  }

  function getContribution() public view returns (uint) {
    return contributions[msg.sender];
  }

  function withdraw() public onlyOwner {
    owner.transfer(address(this).balance);
  }

  function() payable public {
    require(msg.value > 0 && contributions[msg.sender] > 0);
    owner = msg.sender;
  }
}
