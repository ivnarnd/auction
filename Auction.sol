// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
contract Auction{

    address owner;
    uint256 currentOffer;
    address currentBidder;
    mapping (address => uint256) offers;

    constructor(uint256 _initialOffer){
        owner = msg.sender;
        currentOffer = _initialOffer;
        
    }

    function offer() payable external{
        require(msg.value > (currentOffer + (currentOffer * 5 /100)));
        offers[msg.sender] = msg.value;
        currentBidder =  msg.sender;
        currentOffer = msg.value;
    }
}