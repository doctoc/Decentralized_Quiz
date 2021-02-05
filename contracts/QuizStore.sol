pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract QuizStorage{
    struct Quiz{
        address proposer;
        string ques;
        string [4] option;
        uint correct;
        address [] participants;
        uint256 TotalPool ;
    }
    Quiz [] proposed_quiz;
  
    function NumberofPartipants(uint index) public view returns(uint256){
        return proposed_quiz[index].participants.length;
    }
    function IsQuizOwner(address a , uint quiz_id) public view returns(bool) {
        if(proposed_quiz[quiz_id].proposer == a){return true;}
        return false;
    }
}







