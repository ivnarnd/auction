// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
contract Auction{

    address owner;
    uint256 currentOffer;
    address currentBidder;
    uint256 expirationTime;
    mapping (address => uint256) offers;
    /**
        Se inicializa el smart contract con un monto inicial de oferta y
         un tiempo de expiration en segundos
    */
    constructor(uint256 _initialOffer, uint256 _expirationSeconds){
        owner = msg.sender;
        currentOffer = _initialOffer;
        expirationTime = block.timestamp + _expirationSeconds;
        
    }
    
    function offer() payable external{
        require(msg.value > (currentOffer + (currentOffer * 5 /100)));
        offers[msg.sender] = msg.value;
        currentBidder =  msg.sender;
        currentOffer = msg.value;
    }

}