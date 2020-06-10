pragma solidity >=0.4.22 <0.6.0;

library Set {
    struct Data {
        mapping (int => bool) data;
    }
    
    function Insert(Data storage d, int key) public returns (bool) {
        if (d.data[key]) return false; // key exists
        
        d.data[key] = true;
        return true;
    }
    
    function Remove(Data storage d, int key) public returns (bool) {
        if (!d.data[key]) return false; // key doesn't exist
        
        d.data[key] = false;
        return true;
    }
    
    function Contain(Data storage d, int key) public returns (bool) {
        if (!d.data[key]) return false; // key doesn't exist
        
        d.data[key] = false;
        return true;
    }
}
