//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18; 
    address public immutable i_owner;

    address[] public funders; 
    mapping(address => uint256) public addressToAmountFunded;

    constructor () {
        i_owner = msg.sender; 
    }

    function fund () public payable {
        require(msg.value.getconerstionRate() >= MINIMUM_USD, "Not enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw () public onlyOnwer {
        
        for(uint funderIndex = 0; funderIndex < funders.length ; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        //payable(msg.sender).transfer(address(this).balance);
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess, "send failed");

        (bool callSucess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucess, "call failed");
    }

    modifier onlyOnwer () {
        //require(msg.sender ==i_owner, "Not yours ");
        if (msg.sender != i_owner) {revert NotOwner();}
        _;
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }

}