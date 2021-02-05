pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

// stores those vars that may change over time .
contract Variables{
    // #####change view access modifier of state vars;
    uint256 public proposal_fee;
    uint256 public participation_fee;
    uint256 public participant_limit;
    address owner ;
    constructor() public{
        proposal_fee = 200000 ;
        participation_fee = 100000 ;
        participant_limit = 3;
        owner = msg.sender;
    }
    function getowner() internal returns(address){
    	return owner;
    }
    modifier isOwner{
    	require(msg.sender == owner);
    	_;
    }
    // ### include modifiers for admin access ;
    function SetProposalFee(uint256 _fee) external isOwner{
        proposal_fee = _fee;
    }
    function SetParticipationFee(uint256 _fee) external isOwner{
        participation_fee = _fee;
    }
    function SetParticipantLimit(uint256 _limit) external isOwner{
        participant_limit = _limit;
    }
}
