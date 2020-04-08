pragma solidity >=0.4.22 <0.6.0;

contract Donation {
    struct DonerInfo {
        uint256 value;
        bool    is_alive;
    }
    
    struct StreamerInfo {
        address []                      donors;
        mapping (address => DonerInfo)  donor_infos;
        bool                            is_alive;
    }
    
    address []                          _streamers;
    mapping (address => StreamerInfo)   _streamer_infos;
    
    event LogDonation(address streamer, address donor, string nickName, string message, uint256 value);
    
    function donate(address payable streamer, string memory nickName, string memory message) public payable {
        require(msg.value > 0);
        require(streamer == msg.sender);
        
        if (!_streamer_infos[streamer].is_alive) {
            _streamers.push(streamer);
            _streamer_infos[streamer].is_alive = true;
        }
        
        _streamer_infos[streamer].donor_infos[msg.sender].value += msg.value;
        if (!_streamer_infos[streamer].donor_infos[msg.sender].is_alive) {
            _streamer_infos[streamer].donors.push(msg.sender);
            _streamer_infos[streamer].donor_infos[msg.sender].is_alive = true;
        }
        
        streamer.transfer(msg.value);
        emit LogDonation(streamer, msg.sender, nickName, message, msg.value);
    }
    
    function getDonorList() view public returns (address [] memory) {
        return _streamer_infos[msg.sender].donors;
    }

    event LogDonorInfo(address streamer, address donor, uint256 value);
    function listDonorInfo() public {
        for (uint i = 0; i < _streamers.length; i++) {
            address streamer = _streamers[i];
            for (uint j = 0; j < _streamer_infos[streamer].donors.length; j++) {
                address donor = _streamer_infos[streamer].donors[i];
                if (!_streamer_infos[streamer].donor_infos[donor].is_alive) continue;
                
                emit LogDonorInfo(streamer, donor, _streamer_infos[streamer].donor_infos[donor].value);
            }
        }
    }
}
