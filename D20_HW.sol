pragma solidity >=0.4.22 <0.6.0;


import "https://github.com/himochen/my_solidity_30_days/blob/master/IERC20.sol";

contract NewToken is IERC20 {
    struct UserInfo {
        uint256 balance;
        mapping (address => uint256) allowance;
    }
    
    mapping (address => UserInfo) _users;
    uint256 _price = 10;
    
    function totalSupply() external view returns (uint256) {
        return address(this).balance;
    }
    
    function balanceOf(address tokenOwner) external view returns (uint256 balance) {
        return _users[tokenOwner].balance;
    }
    
    function transfer(address to, uint256 tokens) external returns (bool success) {
        if (_users[msg.sender].balance < tokens) return false;
        
        _users[msg.sender].balance -= tokens;
        _users[to].balance += tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }
    
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining) {
        return _users[tokenOwner].allowance[spender];
    }
    
    function approve(address spender, uint256 tokens) external returns (bool success) {
        _users[msg.sender].allowance[spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
    
    function transferFrom(address from, address to, uint256 tokens) external returns (bool success) {
        if (_users[from].balance < tokens) return false;
        if (_users[from].allowance[msg.sender] < tokens) return false;
        
        _users[from].balance -= tokens;
        _users[from].allowance[msg.sender] -= tokens;
        _users[to].balance += tokens;
        emit Transfer(from, to, tokens);
        return true;
    }
    
    function buy() external payable returns (bool success) {
        if (msg.value < _price) return false;
        
        _users[msg.sender].balance += msg.value / _price;
        return true;
    }
}
