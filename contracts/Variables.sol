pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

// stores those vars that may change over time .
contract Variables{
    // #####change view access modifier of state vars;
    uint256 internal proposal_fee;
    uint256 internal participation_fee;
    uint256 internal participant_limit;
    
    constructor() public{
        proposal_fee = 200000 ; // gwei
        participation_fee = 100000 ;
        participant_limit = 3;
    }
    
    // ### include modifiers for admin access ;
    function GetProposalFee() public view returns(uint256){
        return proposal_fee;
    }
    function SetProposalFee(uint256 _fee) public {
        proposal_fee = _fee;
    }
    function GetParticipationFee() public view returns(uint256){
        return participation_fee;
    }
    function SetParticipationFee(uint256 _fee) public {
        participation_fee = _fee;
    }
    function GetParticipantLimit() public view returns(uint256){
        return participant_limit;
    }
    function SetParticipantLimit(uint256 _limit) public {
        participant_limit = _limit;
    }
}
