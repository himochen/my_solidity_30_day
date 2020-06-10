pragma solidity >=0.4.22 <0.6.0;

import {Set} from 'D17_set.sol';

contract Main {
    Set.Data set;
    
    function insert(int key) public returns (bool) {
        return Set.Insert(set, key);
    }
    
    function remove(int key) public returns (bool) {
        return Set.Remove(set, key);
    }
    
    function contain(int key) public returns (bool) {
        return Set.Contain(set, key);
    }
}
