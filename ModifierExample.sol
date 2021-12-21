pragma solidity ^0.5.13;

/**
 * A public whitelist of trusted ETH addresses revisited,
 * this time using a Solidity modifier
 */
contract ModifierExample {

    // owner writes data
    address owner; 

    // a whitelist of trusted addresses - if the address doesn't exist in this mapping then it'll simply return false
    mapping(address => bool) public whitelistedAddresses;

    // the deployer of the contract is the owner
    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(owner == msg.sender, "Only the owner is allowed to do this.");
        _;
    }

    // add an address to the whitelist
    function trustAddress(address _trusted) public onlyOwner {
        whitelistedAddresses[_trusted] = true;
    }

    // remove an address to the whitelist
    function untrustAddress(address _trusted) public onlyOwner {
        whitelistedAddresses[_trusted] = false;
    }

}
