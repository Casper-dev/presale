pragma solidity ^0.4.19;

contract Presale {
    uint constant public cspToMicro = uint(10) ** 18; // 10^18
    uint constant public bonusLevel0 = cspToMicro * 10000 * 100 / 12; // 10000$
    uint constant public bonusLevel1 = cspToMicro * 50000 * 100 / 12; // 50000$
    uint constant public bonusLevel2 = cspToMicro * 100000 * 100 / 12; // 100000$
    uint constant public bonusLevel3 = cspToMicro * 300000 * 100 / 12; // 300000$
    uint constant public bonusLevel4 = cspToMicro * 500000 * 100 / 12; // 500000$

    //https://casperproject.atlassian.net/wiki/spaces/PROD/pages/277839878/Smart+contract+ICO
    //Presale date 15.05 - 30.06.2018 
    //uint256 constant startTime = 1526342400; // 15 May 2018 00:00:00 GMT
    //uint256 constant endTime = 1530403199; // 30 June 2018 23:59:59 GMT
    //address constant CsperWallet = 0x6A5e633065475393211aB623286200910F465d02;

    // address of owner
    address public owner;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function Presale() public {
        owner = msg.sender;
    }

    // For every pre-sale participant this mapping stores
    // amount of 10^-DECIMALS CSP it has.
    mapping (address => uint) public tokens;
    address[] public participants;

    // 100 000 000 Ether in dollars
    uint public ethRate = 0;
    function setETHRate(uint _rate) public onlyOwner {
        ethRate = _rate;
    }

    // 100 000 000 BTC in dollars
    uint public btcRate = 0;
    function setBTCRate(uint _rate) public onlyOwner {
        btcRate = _rate;
    }

    function purchaseWithETH(address _to) payable public whenNotPaused {
        uint _wei = msg.value;
        uint csp = _wei * ethRate / 12000000;
        require(csp >= bonusLevel0);

        owner.transfer(_wei);

        csp = addBonus(csp);
        participants.push(_to);
        tokens[_to] += csp;
    }

    function purchaseWithBTC(address _to, uint _satoshi) public onlyOwner whenNotPaused {
        uint csp = _satoshi * btcRate * 10000 / 12;
        require(csp >= bonusLevel0);

        csp = addBonus(csp);
        participants.push(_to);
        tokens[_to] += csp;
    }

    function addBonus(uint _csp) public pure returns (uint) {
        if (_csp < bonusLevel1) {
            return _csp;
        } else if (_csp < bonusLevel2) {
            return _csp * 105 / 100;
        } else if (_csp < bonusLevel3) {
            return _csp * 110 / 100;
        } else if (_csp < bonusLevel4) {
            return _csp * 115 / 100;
        } else {
            return _csp * 120 / 100;
        }
    }

    bool public paused = true;
    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    modifier whenPaused() {
        require(paused);
        _;
    }

    function pause() onlyOwner whenNotPaused public {
        paused = true;
    }

    function unpause() onlyOwner whenPaused public {
        paused = false;
    }
}