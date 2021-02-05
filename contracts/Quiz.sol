pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./MemberStore.sol";
import "./QuizStore.sol";

// ## include safemath later on......
contract Main is MemberStorage  , QuizStorage{
    uint private count;
    uint private quizcounter ; // choosing the active quiz;
    constructor() public{
        count = 1;
        quizcounter = 1;
    }
    
    function Register(string memory _name) public {
        member[msg.sender] = User(_name , count , 0 , msg.sender , true , 0 , 0);
        count++;
    }
    
    event Staked(uint id , address acc , uint256 amount);
    
    function Stake() public payable {
        
        require(IsMember(msg.sender) , " Please register first");
        require(msg.value >=0 , "Entered Amount Invalid");
        
        User storage user = member[msg.sender]; // user is a pointer to a storage elem.
        user.stake += msg.value;
        emit Staked(user.id , user.acc , msg.value);
    }
    
    // currently a single question quiz .
    // call to propose quiz creates a Quiz in storage and slashes a part of stake of the proposer.
    
    event QuizProposed(address proposer , uint quiz_id , uint correct );
    
    function ProposeQuiz(string memory q , string memory op1 , string memory op2 , string memory op3 , string memory op4 , uint correct) public {
        
        require(IsMember(msg.sender) , "Please register first");
        require(GetStake(msg.sender) >= proposal_fee, "Not enough stake for quiz proposal");
        
        proposed_quiz.push(Quiz(msg.sender ,q , [op1 ,op2,op3,op4] ,correct,  new address[](0) , 0 , false));
        member[msg.sender].quiz_proposed = quizcounter;
        member[msg.sender].stake -= proposal_fee;
        emit QuizProposed(msg.sender , quizcounter , correct);
        quizcounter++;
    }
    
    // in-contract time management ??
    // currently the frontend should handle the pooling period time.
    // The pooling happens for the quiz pointed by quizcounter...
    // Pool() can only be called during pooling period.
    
    event Pooled(address pooler , uint amount , uint quiz_id);
    function Pool(uint256 amount , uint256 quiz_id) public {
        
        require(proposed_quiz[quiz_id].participants.length < participant_limit , "Sorry the quiz participation is full . Please try later ");
        require(GetStake(msg.sender) >= amount , "Not Enough stake ");
        require(amount >= participation_fee , "Minimum participation fee not reached ");
        
        member[msg.sender].stake -= amount;
        proposed_quiz[quiz_id].TotalPool += amount;
        proposed_quiz[quiz_id].participants.push(msg.sender);
        member[msg.sender].quiz_entered = quiz_id;
        emit Pooled(msg.sender , amount , quiz_id);
    }
    
    // if the participants == 0 after pooling time is up Terminate Quiz is called 
    
    function TerminateQuiz(uint quiz_id) public {
        
        require(quiz_id < quizcounter , "Such quiz doesn't exist");
        require(IsQuizOwner(msg.sender , quiz_id) , "Only the quiz owner can call Terminate");
        
        member[msg.sender].stake += proposal_fee;
        delete proposed_quiz[quiz_id];
    }
    
    event Commence(uint quiz_id);
    function CommenceQuiz(uint quiz_id) public {
        
        require(quiz_id < quizcounter , "Such quiz doesn't exist");
        require(IsQuizOwner(msg.sender , quiz_id) , "Only the quiz owner can call Commence");
        
        proposed_quiz[quiz_id].commenced = true;
        emit Commence(quiz_id);
        // notify all participants 
    }
    
    event Answered(address a , uint quiz_id , uint option ); 
 /*   function Answer(uint quiz_id , uint option) public {
    
    	require(quiz_id < quizcounter , "Such quiz doesn't exist");
    	require(hasQuizCommenced(quiz_id) , "Quiz has not started yet");
    	require(IsMember(msg.sender) && hasPooled(msg.sender , quiz_id) , "Cannot allow to answer");
    	
    */	
     
    
    
    
}
