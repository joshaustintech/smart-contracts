pragma solidity ^0.5.13;

contract SendMoneyExample {
    
    // total balance this contract has ever received (in wei)
    // NOT the same as current balance because total and current can
    // be different in the case of withdrawal(s).
    uint public balanceReceived;
    
    // increments balanceReceived when the payment is received
    function receiveMoney() public payable { // 'payable' means that the contract can receive funds when this is called
        balanceReceived += msg.value; 
    }
    
    // returns the current balance of the smart contract (in wei)
    function getBalance() public view returns (uint) {
        return address(this).balance; 
    }
    
    // withdraws the whole current balance of this contract to the address that calls this function
    function withdrawMoney() public {
        address payable to = msg.sender; // 'payable' modifier is needed to determine if an address is meant to receive payment
        to.transfer(this.getBalance());
    }
    
    // withdraws the whole current balance of this contract to the address specified in the '_to' parameter
    function withdrawMoneyTo(address payable _to) public {
        _to.transfer(this.getBalance());
    }
}
