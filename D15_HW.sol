pragma solidity >=0.4.22 <0.6.0;

contract Bank {
    mapping (address => uint256) _depositors;
    constructor() internal {
    }
    
    function Deposit(uint256 count) public {
        _depositors[msg.sender] += count;
    }
    
    function Withdrawal(uint256 count) public {
        require(_depositors[msg.sender] > count);
        _depositors[msg.sender] -= count;
    }
    
    function GetBalance() public view returns (uint256) {
        return _depositors[msg.sender];
    }
}

contract SimpleBank is Bank {
    
}

contract SpecialBank is Bank {
    uint256 evil_gap = 10;
    
    function DepositEvil(uint256 count) public {
        Deposit(count+evil_gap);
    }
    
    function WithdrawalEvil(uint256 count) public {
        Withdrawal(count+evil_gap*5);
    }
}
