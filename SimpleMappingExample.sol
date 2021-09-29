pragma solidity ^0.6.0;

contract SimpleMappingExample {
    mapping (uint => bool) public myMapping;
    
    function setValue(uint _index) public {
        myMapping[_index] = true;
    }
}
