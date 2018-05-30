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
}

contract CasperToken is ERC20Interface, Owned {
    using SafeMath for uint;

    string public constant name = "Csper Token";
    string public constant symbol = "CST";
    uint8 public constant decimals = 18;

    uint constant public cstToMicro = uint(10) ** decimals;
    uint constant public _totalSupply    = 440000000 * cstToMicro;
    uint constant public preICOSupply    = 13000000 * cstToMicro;
    uint constant public presaleSupply   = 238333333 * cstToMicro;
    uint constant public crowdsaleSupply = 19750000 * cstToMicro;
    uint constant public systemSupply    = 35500000 * cstToMicro;
    uint constant public investorSupply  = 47666667 * cstToMicro;
    uint constant public teamSupply      = 66000000 * cstToMicro;
    uint constant public adviserSupply   = 7000000 * cstToMicro;
    uint constant public bountySupply    = 8800000 * cstToMicro;
    uint constant public referralSupply  = 3950000 * cstToMicro;

    uint public presaleSold = 0;
    uint public crowdsaleSold = 0;
    uint public ethSold = 0;

    uint constant public bonusLevel0 = cstToMicro * 10000 * 100 / 12; // 10000$
    uint constant public bonusLevel5 = cstToMicro * 50000 * 100 / 12; // 50000$
    uint constant public bonusLevel10 = cstToMicro * 100000 * 100 / 12; // 100000$
    uint constant public bonusLevel15 = cstToMicro * 300000 * 100 / 12; // 300000$
    uint constant public bonusLevel20 = cstToMicro * 500000 * 100 / 12; // 500000$

    uint constant public unlockDate1 = 1538179199; // 28.09.2018 23:59:59
    uint constant public unlockDate2 = 1543622399; // 30.11.2018 23:59:59
    uint constant public unlockDate3 = 1548979199; // 31.01.2019 23:59:59
    uint constant public unlockDate4 = 1554076799; // 31.03.2019 23:59:59
    uint constant public unlockDate5 = 1559347199; // 31.05.2019 23:59:59    

    address constant ACSTContract = 0x0;
    address constant PreICOContract = 0x0;

    //https://casperproject.atlassian.net/wiki/spaces/PROD/pages/277839878/Smart+contract+ICO
    // Presale 10.06.2018 - 22.07.2018
    // Crowd-sale 23.07.2018 - 2.08.2018 (16.08.2018)
    uint constant public presaleStartTime     = 1528588800;
    uint constant public crowdsaleStartTime   = 1532304000;
    uint          public crowdsaleEndTime     = 1533168000;
    uint constant public crowdsaleHardEndTime = 1534377600;
    //address constant CsperWallet = 0x6A5e633065475393211aB623286200910F465d02;
    function CasperToken() public {
        balances[owner] = _totalSupply;
        Transfer(address(0), owner, _totalSupply);

        // TODO pre-ICO convertation 1 CSPT -> 10 CST
        //allowed[owner][0x0] = 10 * 0;

        // TODO adviser token convertation
        //approve(0x096ad02a48338CB9eA967a96062842891D195Af5, 833333333333333333334);

        // TODO team allocations
        //allowed[owner][0x0] = 123;
    }

    mapping(address => bool) public kyc;
    function kycPassed(address _mem) public onlyOwner {
        kyc[_mem] = true;
    }

    // For every pre-sale participant this mapping stores
    // amount of 10^-decimals CST it has.
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
    address[] public participants;

    mapping(address => uint) freezed;

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
        uint newBalance = balances[msg.sender].sub(tokens);
        checkTransfer(msg.sender, newBalance);

        balances[msg.sender] = newBalance;
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
        uint newBalance = balances[from].sub(tokens);
        checkTransfer(from, newBalance);

        balances[from] = newBalance;
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
        balances[to] = balances[to].add(tokens);
        Transfer(from, to, tokens);
        return true;
    }

    function checkTransfer(address from, uint newBalance) public view {
        if (now < unlockDate5 && from != owner) {
            if (now < unlockDate1) {
                // all tokens are locked
                revert();
            } else if (now < unlockDate2) {
                // 20% of tokens are unlocked
                require(newBalance >= freezed[from].mul(80).div(100));
            } else if (now < unlockDate3) {
                // 40% of tokens are unlocked
                require(newBalance >= freezed[from].mul(60).div(100));
            } else if (now < unlockDate4) {
                // 60% of tokens are unlocked
                require(newBalance >= freezed[from].mul(40).div(100));
            } else {
                // 80% of tokens are unlocked
                require(newBalance >= freezed[from].mul(20).div(100));
            }
        }
    }

    function ICOStatus() public view returns (uint usd, uint eth, uint cst) {
        usd = presaleSold.mul(12).div(10**20) + crowdsaleSold.mul(16).div(10**20);
        return (usd, ethSold, presaleSold + crowdsaleSold);
    }

    function transferBonus(address _to, uint _usd) public {
        uint dollars;
        (dollars, , ) = ICOStatus();
        require(dollars > 4800000);

        uint cst = _usd.mul(100).mul(cstToMicro).div(12); // presale tariff
        presaleSold = presaleSold.add(cst);
        ethSold = ethSold.add(_usd.mul(10**8).div(ethRate));

        _preTransfer(_to, cst);
    }

    function prolongCrowdsale() public onlyOwner {
        crowdsaleEndTime = crowdsaleHardEndTime;
    }

    // 100 000 000 Ether in dollars
    uint public ethRate = 0;
    uint public ethLastUpdate = 0;
    function setETHRate(uint _rate) public onlyOwner {
        ethRate = _rate;
        ethLastUpdate = now;
    }

    // 100 000 000 BTC in dollars
    uint public btcRate = 0;
    uint public btcLastUpdate;
    function setBTCRate(uint _rate) public onlyOwner {
        btcRate = _rate;
        btcLastUpdate = now;
    }

    function _sellPresale(uint cst) private {
        require(cst >= bonusLevel0.mul(9997).div(10000));
        presaleSold = presaleSold.add(cst);
        require(presaleSold <= presaleSupply);
    }

    function _sellCrowd(uint cst, address _to) private {
        crowdsaleSold = crowdsaleSold.add(cst);
        require(crowdsaleSold <= crowdsaleSupply);
        if (now + 3 days < crowdsaleStartTime) {
            if (whitemap[_to] >= cst) {
                whitemap[_to] -= cst;
                whitelistTokens -= cst;
            } else {
                require(crowdsaleSupply >= crowdsaleSold + whitelistTokens + cst);
            }
        }
    }

    function addInvestorBonus(address _to, uint8 p) public {
        require(p > 0 && p <= 5);
        uint bonus = balances[_to].mul(p).div(100);
        _preTransfer(_to, bonus);
    }

    function _preTransfer(address _to, uint cst) private {
        if (balanceOf(_to) == 0) {
            participants.push(_to);
        }
        balances[owner] = balances[owner].sub(cst);
        balances[_to] = balances[_to].add(cst);
        freezed[_to] = balances[_to];
        Transfer(owner, _to, cst);
    }

    function purchaseWithETH(address _to) payable public {
        require(now >= presaleStartTime && now <= crowdsaleEndTime);
        uint _wei = msg.value;
        uint cst;

        ethSold += _wei;

        // accept payment on presale only if it is more than 9997$
        if (now < crowdsaleStartTime) {
            cst = _wei.mul(ethRate).div(12000000); // 1 CST = 0.12 $ on presale
            _sellPresale(cst);
            cst = calcBonus(cst);
        } else {
            cst = _wei.mul(ethRate).div(16000000); // 1 CST = 0.16 $ on crowd-sale
            _sellCrowd(cst, _to);
        }

        assert(cst != 0);

        owner.transfer(_wei);

        _preTransfer(_to, cst);
    }

    function purchaseWithBTC(address _to, uint _satoshi, uint _wei) public onlyOwner {
        require(now >= presaleStartTime && now <= crowdsaleEndTime);

        ethSold += _wei;

        uint cst;
         // accept payment on presale only if it is more than 9997$
        if (now < crowdsaleStartTime) {
            cst = _satoshi.mul(btcRate.mul(10000)) / 12; // 1 CST = 0.12 $ on presale
            _sellPresale(cst);
            cst = calcBonus(cst);
        } else {
            cst = _satoshi.mul(btcRate.mul(10000)) / 16; // 1 CST = 0.16 $ on presale
            _sellCrowd(cst, _to);
        }

        assert(cst != 0);

        _preTransfer(_to, cst);
    }

    // calculate bonus for presale
    function calcBonus(uint _cst) public pure returns (uint) {
        if (_cst < bonusLevel5) {
            return _cst;
        } else if (_cst < bonusLevel10) {
            return _cst.mul(105).div(100);
        } else if (_cst < bonusLevel15) {
            return _cst.mul(110).div(100);
        } else if (_cst < bonusLevel20) {
            return _cst.mul(115).div(100);
        } else {
            return _cst.mul(120).div(100);
        }
    }

    mapping(address => uint) public whitemap;
    uint public whitelistTokens = 0;
    address[] public whiteList;
    function addWhitelistMember(address _mem, uint _tokens) public {
        if (whitemap[_mem] == 0) {
            whiteList.push(_mem);
        }
        whitemap[_mem] = _tokens;
        whitelistTokens.add(_tokens);
    }

    address[] public teamList;
    function addTeamMember(address member) public onlyOwner {
        teamList.push(member);
    }

    mapping(address => uint) public airdropMap;
    address[] public airdropList;
    function addAirdropMember(address _mem, uint _tokens) public onlyOwner {
        if (airdropMap[_mem] == 0) {
            airdropList.push(_mem);
        }
        airdropMap[_mem] = airdropMap[_mem].add(_tokens);
        bountySold.add(_tokens);
        require(bountySold <= bountySupply);
    }
    // TODO think about gas limit
    function doAirdrop(uint _first) public onlyOwner {
        uint len = airdropList.length;
        for(uint i = _first; i < len; i++) {
            address to = airdropList[i];
            uint tokens = airdropMap[to];
            balances[owner] = balances[owner].sub(tokens);
            balances[to] = balances[to].add(tokens);
            Transfer(owner, to, tokens);
            delete airdropMap[to];
        }
        airdropList.length = _first;
    }

    mapping(address => uint) public bountyMap;
    uint public bountySold = 0;
    address[] public bountyList;
    function addBountylistMember(address _mem, uint _tokens) public onlyOwner {
        if (bountyMap[_mem] == 0) {
            bountyList.push(_mem);
        }
        bountyMap[_mem] = bountyMap[_mem].add(_tokens);
        bountySold.add(_tokens);
        require(bountySold <= bountySupply);
    }

    // TODO think about gas limit
    function doBounty(uint _first) public onlyOwner {
        uint len = bountyList.length;
        for(uint i = _first; i < len; i++) {
            address to = bountyList[i];
            uint tokens = bountyMap[to];
            balances[owner] = balances[owner].sub(tokens);
            balances[to] = balances[to].add(tokens);
            Transfer(owner, to, tokens);
            delete bountyMap[to];
        }
        bountyList.length = _first;
    }

    mapping(address => uint) public adviserMap;
    uint public adviserSold = 0;
    address[] public adviserList;
    function addAdviser(address _adv, uint _tokens) public onlyOwner {
        if (adviserMap[_adv] == 0) {
            adviserList.push(_adv);
        }
        adviserMap[_adv] = adviserMap[_adv].add(_tokens);
        adviserSold.add(_tokens);
        require(adviserSold <= adviserSupply);
    }
}