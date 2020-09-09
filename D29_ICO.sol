pragma solidity ^0.5.0;

import "https://github.com/himochen/my_solidity_30_days/blob/master/SafeMath.sol";
import "browser/D29_ICO_token.sol";

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
        owner = msg.sender;
        string memory name = "HYDAIToken";
        uint8 decimals = 18;
        string memory symbol = "HYT";
        uint256 totalSupply = 1000*(10**18);
        mCaps = totalSupply;
        mTokenAddress = new ICOToken(name, decimals, symbol, totalSupply);
        mICOState = ICOState.INITIAL;
    }
    //=========================================================================
    
    
    //=== Functions ===========================================================
    function startICO() public onlyOwner beforICOStart {
        mICOState = ICOState.START;
    }
    function endICO() public onlyOwner whenICOStart {
        mICOState = ICOState.END;
        owner.transfer(address(this).balance);
        IERC20(mTokenAddress).transfer(owner, mCaps.sub(mCurrentFund));
    }
    //=========================================================================
    
    
    //=== Fallback Function ===================================================
    function() external payable whenICOStart {
        require(msg.value > 0);
        require(mCaps >= mCurrentFund + msg.value);
        mCurrentFund = mCurrentFund.add(msg.value);
        IERC20(mTokenAddress).transfer(msg.sender, msg.value);
    }
    //=========================================================================
}
