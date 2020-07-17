pragma solidity >=0.4.22 <0.6.0;

// ERC20 Mintable

import "https://github.com/himochen/my_solidity_30_days/blob/master/SafeMath.sol";
import "https://github.com/himochen/my_solidity_30_days/blob/master/IERC20.sol";

contract Mintable is IERC20 {
    // ERC20 Optional
    
    // Use SafeMath to implement ERC20
    function totalSupply() external view returns (uint256);
    function balanceOf(address tokenOwner) external view returns (uint256 balance);
    function transfer(address to, uint256 tokens) external returns (bool success);
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining);
    function approve(address spender, uint256 tokens) external returns (bool success);
    function transferFrom(address from, address to, uint256 tokens) external returns (bool success);
    
    // Implement mint
    function mint(address account, uint256 tokens) public onlyMinter returns (bool) {
    }
    
    function approveMinter(address minter, uint256 tokens) public onlyOwner returns (bool) {
    }

    // Implement burn
    function burn(address account, uint256 tokens) public onlyBurner returns (bool) {
    }
    
    function approveBurner(address minter, uint256 tokens) public onlyOwner returns (bool) {
    }
}
