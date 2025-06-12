// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
contract Auction{

    address owner;
    uint256 currentOffer;
    address currentBidder;
    uint256 expirationTime;

    mapping (address => Offer[]) public offers;
    mapping(address => uint256) public refund;
    Offer[] public  allOffers;
    struct Offer {
        address bidder;
        uint amount;
    }

    /**
        Se inicializa el smart contract con un monto inicial de oferta y
         un tiempo de expiration en segundos
    */
    constructor(uint256 _initialOffer, uint256 _expirationSeconds){
        owner = msg.sender;
        currentOffer = _initialOffer;
        expirationTime = block.timestamp + _expirationSeconds;
        currentBidder;
        
    }
    /**
        Permite corroborar que la subasta todavia no finalizo
     */
    modifier available() {
        require(block.timestamp < expirationTime, "La subasta ya finalizo");
        _;
    }
    event NewOffer(address indexed bidder, uint256 amount);
    /*
        offer recibe una transferencia y corrobora a traves de avaible que todavia esta a tiempo de ofertar
        que solo se acepta si el monto a depositar es mayor igual en un 5% a la oferta actual se acepta   
     */
    function offer() payable external available(){
        require(msg.value >= (currentOffer + (currentOffer * 5 /100)),"Su oferta debe superar en 5% La Oferta Actual");
        if(allOffers.length > 0){
            refund[currentBidder] += currentOffer;
        }
        Offer memory newOffer = Offer(msg.sender,msg.value);
        offers[msg.sender].push(newOffer);
        allOffers.push(newOffer);
        currentBidder =  msg.sender;
        currentOffer = msg.value;
        if(expirationTime-block.timestamp < 10 minutes){
            expirationTime += 10 minutes;
        }
        emit NewOffer(msg.sender,msg.value);
    }

}