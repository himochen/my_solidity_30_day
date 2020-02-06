pragma solidity >=0.4.22 <0.6.0;

contract login {
    address _addr;
    string _name;
    
    event LogFallback(string msg);
    event LogBalance(uint balance);
    
    constructor() public {
        _addr = msg.sender;
    }
    
    function get_name() public view returns (string memory) {
        return _name;
    }
    
    function set_name(string memory name) public {
        _name = name;
        // assert(_addr == msg.sender);
        require(_addr == msg.sender, "You SHOULD NOT pass!!!!!");
    }
    
    function() external payable {
        if (_addr == msg.sender) {
            msg.sender.transfer(address(this).balance);
            emit LogFallback("HaHaHa!");
        } else {
            emit LogFallback("Thank you!");
        }
        
        emit LogBalance(address(this).balance);
    }
}
