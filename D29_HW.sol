pragma solidity ^0.5.0;

import "https://github.com/himochen/my_solidity_30_days/blob/master/SafeMath.sol";
import "https://github.com/himochen/my_solidity_30_days/blob/master/D29_ICO_token.sol";

contract ICO {
    //=== Library =============================================================
    using SafeMath for uint;
    //=========================================================================
    
    //=== Enum ================================================================
    enum ICOState {INITIAL, START, END}
    //=========================================================================
    
    //=== State Variables =====================================================
    address payable private owner;
    IERC20 public mTokenAddress;
    uint256 mCaps = 0; 
    uint256 mCurrentFund = 0;
    ICOState mICOState = ICOState.INITIAL;
    //=========================================================================
    
    //=== Modifiers ===========================================================
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier beforICOStart() {
        require(mICOState == ICOState.INITIAL);
        _;
    }
    modifier whenICOStart() {
        require(mICOState == ICOState.START);
        _;
    }
    modifier whenICOEnd() {
        require(mICOState == ICOState.END);
        _;
    }
    //=========================================================================
    
    //=== Constructor =========================================================
    constructor() public {
        // Set owner
        // Set token name
        // Set token decimals
        // Set token symbol
        // Set token total totalSupply
        // Create ICOToken by name, decimals, totalSupply
    }
    //=========================================================================
    
    //=== Functions ===========================================================
    function startICO() public onlyOwner beforICOStart {
    }
    
    function endICO() public onlyOwner whenICOStart {
        // Send ether back to owner
        // Send remaining tokens back to owner
    }
    //=========================================================================
    
    
    //=== Fallback Function ===================================================
    function() external payable whenICOStart {
        // Transfer 1:1 tokens to sender
    }
    //=========================================================================
}
