pragma solidity ^0.5.13;

/**
 * A simple contract that receives funds that only the owner can withdraw.
 * Owner can also pause and/or destroy the smart contract instance.
 */

// reusable owner functionality is placed here
contract OwnerOperated {

    address payable owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner.");
        _;
    }

}

// reusable owner functionality is inherited here
contract InheritanceExample is OwnerOperated {

    bool paused;

    constructor() public {
        paused = false;
    }

    modifier checkPause() {
        require(!paused, "Contract is paused.");
        _;
    }

    function receiveMoney() public payable checkPause {}

    function getBalance() public view returns (uint) {
        return address(this).balance; 
    }

    function withdrawMoney() public onlyOwner checkPause {
        address payable to = msg.sender; // 'payable' modifier is needed here for an address passed in transfer()
        to.transfer(this.getBalance());
    }

    function setPaused(bool _paused) public onlyOwner {
        paused = _paused;
    }

    function destroyContract() public onlyOwner {
        selfdestruct(owner);
    }
    
    function () external payable {
        receiveMoney();
    }

}
