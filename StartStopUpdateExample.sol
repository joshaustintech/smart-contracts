pragma solidity ^0.5.13;

contract StartStopUpdateExample {
    
    address owner;
    bool paused;
    
    constructor() public { // runs only once during deployment
        owner = msg.sender;
        paused = false;
    }
    
    function deposit() public payable {}
    
    function setPaused(bool _paused) {
        require(msg.sender == owner, "Only the owner can pause the contract.");
        paused = _paused;
    }
    
    function withdrawAll(address payable _to) public {
        require(msg.sender == owner, "Only the owner can withdraw funds.");
        require(!paused, "Contract is paused.");
        _to.transfer(address(this).balance);
    }
    
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "Only the owner can destroy the contract.");
        selfdestruct(_to);
    }
    
}
