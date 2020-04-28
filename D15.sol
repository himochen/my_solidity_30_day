pragma solidity >=0.4.22 <0.6.0;

// abstract contract
contract Ownable {
  address payable public owner;

  // it makes contract to be abstract
  constructor() internal {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    if (msg.sender == owner)
      _;
  }

  function transferOwnership(address payable newOwner) public onlyOwner {
    if (newOwner != address(0)) owner = newOwner;
  }
  
  // abstract function: it also makes contract to be abstract
  function getOwner() public view returns (address);
}

contract Main is Ownable {
    string _name;
    function ModifyName(string memory new_name) public onlyOwner {
        _name = new_name;
    }
    
    function GetName() public view returns (string memory) {
        return _name;
    }
    
    function getOwner() public view returns (address) {
        return owner;
    }
}
