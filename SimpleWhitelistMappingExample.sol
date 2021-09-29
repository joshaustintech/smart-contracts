pragma solidity ^0.6.0;

contract SimpleWhitelistMappingExample {
    // owner writes data
    address owner;
    
    // A whitelist of trusted addresses - if the address doesn't exist in this mapping then it'll simply return false
    mapping(address => bool) public whitelistedAddresses;
    
    // the deployer of the contract is the owner
    constructor() public {
        owner = msg.sender;
    }
    
    // add an address to the whitelist
    function trustAddress(address _trusted) public {
        require(owner == msg.sender, "Only the owner can trust an address");
        whitelistedAddresses[_trusted] = true;
    }

}
