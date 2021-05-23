pragma solidity >=0.5.0 <0.6.0;
contract LuckyDraw{
    
    uint prizeMoney=0;
    
    address payable [] listOfParticipants; 
    
    address owner; // stores address of owner
    
    //setting the owner
    constructor() public {
        owner=msg.sender;
    }
    
    modifier fee(){
        require(msg.value>=0.1 ether);
        _;
    }
    
    modifier onlyOwner(){
        require(msg.sender==owner);
        _;
    }
    
    //pariticipate in lucky draw
    
    function takePart() external payable fee{
       if(msg.value> 0.1 ether || msg.value< 0.1 ether){
           revert();
       }
        listOfParticipants.push(msg.sender);
        prizeMoney+=msg.value;
    
    }
    
    //display total prize money in wei
    
     function Prize_Money() view public returns(uint){
         return prizeMoney;
     }
   
    // randomly selecting a number
    
    function randomnumber() private view  returns(uint){
        return uint(keccak256(abi.encode(block.difficulty,now,listOfParticipants)));
    }
    
    //choosing a winner (only by owner)    
    
    function chooseWinner()  public payable  onlyOwner {
        uint sno = randomnumber() % listOfParticipants.length ;
        listOfParticipants[sno].transfer(address(this).balance);
        listOfParticipants = new address payable[] (0);
    }
    
}