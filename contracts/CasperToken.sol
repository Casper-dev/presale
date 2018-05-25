pragma solidity ^0.4.19;

// ----------------------------------------------------------------------------
// Safe maths
// ----------------------------------------------------------------------------
library SafeMath {
    function add(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }
    function sub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }
    function mul(uint a, uint b) internal pure returns (uint c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }
    function div(uint a, uint b) internal pure returns (uint c) {
        require(b > 0);
        c = a / b;
    }
}

// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// ----------------------------------------------------------------------------
contract ERC20Interface {
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


// ----------------------------------------------------------------------------
// Owned contract
// ----------------------------------------------------------------------------
contract Owned {
    address public owner;
    address public newOwner;

    event OwnershipTransferred(address indexed _from, address indexed _to);

    function Owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        newOwner = _newOwner;
    }
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        OwnershipTransferred(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}

// ----------------------------------------------------------------------------
// Pausable contract
// ----------------------------------------------------------------------------
contract Pausable is Owned {
    bool public paused;

    function Pausable() public {
        paused = true;
    }

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

contract CasperToken is ERC20Interface, Pausable {
    using SafeMath for uint;

    string public constant name = "Csper Token";
    string public constant symbol = "CSP";
    uint8 public constant decimals = 18;  // 18 is the most common number of decimal places

    uint constant public cspToMicro = uint(10) ** decimals; // 10^18
    uint constant public _totalSupply = 238333333 * cspToMicro;

    uint constant public bonusLevel0 = cspToMicro * 10000 * 100 / 12; // 10000$
    uint constant public bonusLevel5 = cspToMicro * 50000 * 100 / 12; // 50000$
    uint constant public bonusLevel10 = cspToMicro * 100000 * 100 / 12; // 100000$
    uint constant public bonusLevel15 = cspToMicro * 300000 * 100 / 12; // 300000$
    uint constant public bonusLevel20 = cspToMicro * 500000 * 100 / 12; // 500000$

    address constant ACSTContract = 0x0;
    address constant PreICOContract = 0x0;

    //https://casperproject.atlassian.net/wiki/spaces/PROD/pages/277839878/Smart+contract+ICO
    // Presale 10.06.2018 - 22.07.2018
    // Crowd-sale 23.07.2018 - 2.08.2018 (16.08.2018)
    uint constant presaleStartTime = 0;
    uint constant crowdsaleStartTime = 0;
    uint constant crowdsaleEndTime = 0;
    uint constant crownsaleHardEndTime = 0;
    //address constant CsperWallet = 0x6A5e633065475393211aB623286200910F465d02;
    function CasperToken() public {
        balances[owner] = _totalSupply;
        Transfer(address(0), owner, _totalSupply);
    }

    // For every pre-sale participant this mapping stores
    // amount of 10^-decimals CSP it has.
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
    address[] public participants;

    function totalSupply() public view returns (uint) {
        return _totalSupply - balances[owner];
    }
    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }
    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }
    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = balances[msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        Transfer(msg.sender, to, tokens);
        return true;
    }
    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        Approval(msg.sender, spender, tokens);
        return true;
    }
    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = balances[from].sub(tokens);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        Transfer(from, to, tokens);
        return true;
    }

    // 100 000 000 Ether in dollars
    uint public ethRate = 0;
    uint public ethLastUpdate = 0;
    function setETHRate(uint _rate) public onlyOwner {
        ethRate = _rate;
        ethLastUpdate = block.timestamp;
    }

    // 100 000 000 BTC in dollars
    uint public btcRate = 0;
    uint public btcLastUpdate;
    function setBTCRate(uint _rate) public onlyOwner {
        btcRate = _rate;
        btcLastUpdate = block.timestamp;
    }

    function purchaseWithETH(address _to) payable public whenNotPaused {
        uint _wei = msg.value;
        uint csp = _wei.mul(ethRate) / 12000000;
        require(csp >= bonusLevel0);

        owner.transfer(_wei);
        
        csp = calcBonus(csp);
        if (balanceOf(_to) == 0) {
            participants.push(_to);
        }

        balances[owner] = balances[owner].sub(csp);
        balances[_to] = balances[_to].add(csp);
    }

    function purchaseWithBTC(address _to, uint _satoshi) public onlyOwner whenNotPaused {
        uint csp = _satoshi.mul(btcRate.mul(10000)) / 12;
        require(csp >= bonusLevel0);

        csp = calcBonus(csp);
        if (balanceOf(_to) == 0) {
            participants.push(_to);
        }
        balances[owner] = balances[owner].sub(csp);
        balances[_to] = balances[_to].add(csp);
    }

    function calcBonus(uint _csp) public pure returns (uint) {
        if (_csp < bonusLevel5) {
            return _csp;
        } else if (_csp < bonusLevel10) {
            return _csp.mul(105).div(100);
        } else if (_csp < bonusLevel15) {
            return _csp.mul(110).div(100);
        } else if (_csp < bonusLevel20) {
            return _csp.mul(115).div(100);
        } else {
            return _csp.mul(120).div(100);
        }
    }
}