pragma solidity ^0.5.13;

contract AnotherMoneyExample {

    address payable owner;
    mapping(address => uint) public balanceReceived;

    constructor() public {
        owner = msg.sender;
    }

    // a "view" function
    function getOwner() public view returns(address) {
        return owner;
    }

    // a "pure" function, doesn't interact with any storage variables
    function convertWeiToEther(uint _amountInWei) public pure returns(uint) {
        return _amountInWei / 1 ether;
    }

    function addToBalance(address _account, uint _amount) private {
        assert(balanceReceived[_account] + _amount >= balanceReceived[_account]);
        balanceReceived[_account] += _amount;
    }

    function receiveMoney() public payable {
        addToBalance(msg.sender, msg.value);
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "not enough funds");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    // a "fallback" function - treating it like a "tip jar"
    function() external payable {
        addToBalance(owner, msg.value);
    }

}
