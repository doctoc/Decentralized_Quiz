pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./Variables.sol";

contract MemberStorage is Variables{
    struct User {
        string name ;
        uint id ;
        uint stake ;
        address acc;
        bool exists;
        uint quiz_proposed;  // 0 for no quiz
        uint quiz_entered ;// 0 for no quiz 
    }
    mapping(address =>User) member;
    
    function IsMember(address a) public  view returns(bool){
        if(member[a].exists == true){return true;}
        return false;
    }
    

    function GetStake(address a ) public view returns(uint256){
        require(IsMember(a) , "Please register first");
        return member[a].stake;
    }
}
