pragma solidity ^0.5.0;

import "https://github.com/himochen/my_solidity_30_days/blob/master/SafeMath.sol";
import "https://github.com/himochen/my_solidity_30_days/blob/master/IERC20.sol";

contract ICOToken is IERC20 {
    //=== Library =============================================================
    using SafeMath for uint256;
    //=========================================================================
    
    //=== State Variables =====================================================
    string mName = "ICOToken";
    uint8 mDecimals = 18;
    string mSymbol = "ICO";
    uint256 mTotalSupply = 0;
    mapping(address => uint256) mBalances;
    mapping(address => mapping(address => uint256)) mApprove;
    //=========================================================================
    
    //=== Constructor =========================================================
    constructor(
        string memory pName,
        uint8 pDecimals,
        string memory pSymbol,
        uint256 pTotalSupply)
        public
    {
        mName = pName;
        mDecimals = pDecimals;
        mSymbol = pSymbol;
        mTotalSupply = pTotalSupply;
        mBalances[msg.sender] = mBalances[msg.sender].add(mTotalSupply);
        emit Transfer(address(this), msg.sender, mTotalSupply);
    }
    //=========================================================================
    
    
    //=== ERC20 Functions =====================================================
    // 所有存在的 Token 數量
    function totalSupply() external view returns (uint256) {
        return mTotalSupply;
    }
    
    // 讀取 tokenOwner 這個 address 所持有的 Token 數量
    // address => uint256
    function balanceOf(address tokenOwner) external view returns (uint256 balance) {
        return mBalances[tokenOwner];
    }
    
    // 從 msg.sender 轉 tokens 個 Token 給 to 這個 address
    // msg.sender ---tokens---> to 
    function transfer(address to, uint256 tokens) external returns (bool success) {
        return _transfer(msg.sender, to, tokens);
    }
    
    // 得到 tokenOwner 授權給 spender 使用的 Token 剩餘數量
    function allowance(address tokenOwner, address spender) external view returns (uint256 remaining) {
        return mApprove[tokenOwner][spender];
    }
  
    // tokenOwner -> spender -> tokens
    // address => address => uint256
    // msg.sender 授權給 spender 可使用自己的 tokens 個 Token
    function approve(address spender, uint256 tokens) external returns (bool success) {
        mApprove[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    // 將 tokens 個 Token 從 from 轉到 to
    function transferFrom(address from, address to, uint256 tokens) external returns (bool success) {
        mApprove[from][msg.sender] = mApprove[from][msg.sender].sub(tokens);
        
        return _transfer(from, to, tokens);
    }
    
    function _transfer(address from, address to, uint256 tokens) internal returns (bool success) {
        mBalances[from] = mBalances[from].sub(tokens);
        mBalances[to] = mBalances[to].add(tokens);
        emit Transfer(from, to, tokens);
        return true;
    }
    //=========================================================================
    
    
    //=== ERC20 Detail information ============================================
    function name() public view returns (string memory) {
        return mName;
    }
    
    function decimals() public view returns (uint8) {
        return mDecimals;
    }
    
    function symbol() public view returns (string memory) {
        return mSymbol;
    }
    //=========================================================================
}
