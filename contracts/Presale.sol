pragma solidity ^0.4.19;

contract Presale {
    string public NAME = "Csper presale Token";
    string public SYMBOL = "CSP";
    uint8 public DECIMALS = 18;
    uint public INITIAL_SUPPLY = 12000;

    //https://casperproject.atlassian.net/wiki/spaces/PROD/pages/277839878/Smart+contract+ICO
    //Presale datum 15.05 - 30.06.2018 
    uint256 constant startTime = 1526342400; // 15 May 2018 00:00:00 GMT
    uint256 constant endTime = 1530403199; // 30 June 2018 23:59:59 GMT

    // address of owner
    address public owner;

    function Presale(uint256 _startTime, uint256 _endTime) public{
        owner = msg.sender;
    }

    // 1 Mether = 1000000 Ether in dollars
    uint private exchangeRate = 0;

    function setExchangeRate(uint exch) public onlyOwner {
        exchangeRate = exch;
    }

    function purchaseTokens(uint _wei) public {
        require((block.timestamp >= startTime) && (block.timestamp <= endTime));
        _;
    }

    function calcTokenAmount(uint _dollars) public returns (uint) {
        if (_dollars < 10000) {
            return (_dollars * 100) / 16;
        }

        uint cents;
        if (_dollars < 100000) {
            cents = _dollars * 100;
        } else if (_dollars < 300000) {
            cents = _dollars * 110;
        } else if (_dollars < 500000) {
            cents = _dollars * 115;
        } else {
            cents = _dollars * 120;
        }

        return cents / 12;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}