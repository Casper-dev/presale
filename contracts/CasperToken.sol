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

    function convertPreico() public onlyOwner {
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 10 * 19514560000000000000000);
        transfer(0xF5dF9C2aAe5118b64Cda30eBb8d85EbE65A03990, 10 * 36084880000000000000000);
        transfer(0x5D8aCe48970dce4bcD7f985eDb24f5459Ef184Ec, 10 * 2492880000000000000000);
        transfer(0xcD6d5b09a34562a1ED7857B19b32bED77417655b, 10 * 1660880000000000000000);
        transfer(0x50f73AC8435E4e500e37FAb8802bcB840bf4b8B8, 10 * 94896880000000000000000);
        transfer(0x65Aa068590216cb088f4da28190d8815C31aB330, 10 * 16075280000000000000000);
        transfer(0x2046838D148196a5117C4026E21C165785bD3982, 10 * 5893680000000000000000);
        transfer(0x458e1f1050C34f5D125437fcEA0Df0aA9212EDa2, 10 * 32772040882120167215360);
        transfer(0x12B687E19Cef53b2A709e9b98C4d1973850cA53F, 10 * 70956080000000000000000);
        transfer(0x1Cf5daAB09155aaC1716Aa92937eC1c6D45720c7, 10 * 3948880000000000000000);
        transfer(0x32fAAdFdC7938E7FbC7386CcF546c5fc382ed094, 10 * 88188880000000000000000);
        transfer(0xC4eA6C0e9d95d957e75D1EB1Fbe15694CD98336c, 10 * 81948880000000000000000);
        transfer(0xB97D3d579d35a479c20D28988A459E3F35692B05, 10 * 121680000000000000000);
        transfer(0x65AD745047633C3402d4BC5382f72EA3A9eCFe47, 10 * 5196880000000000000000);
        transfer(0xd0BEF2Fb95193f429f0075e442938F5d829a33c8, 10 * 223388880000000000000000);
        transfer(0x9Fc87C3d44A6374D48b2786C46204F673b0Ae236, 10 * 28284880000000000000000);
        transfer(0x42C73b8945a82041B06428359a94403a2e882406, 10 * 13080080000000000000000);
        transfer(0xa4c9595b90BBa7B4d805e555E477200C61711F3a, 10 * 6590480000000000000000);
        transfer(0xb93b8ceD7CD86a667E12104831b4d514365F9DF8, 10 * 116358235759665569280);
        //transfer(0xD00D4E40DAFF894961Cf10458FD283c58e12CF4f, 10 * 0);
        //transfer(0x426043334762056a853e8Cfd8231e72E27Af5Cb7, 10 * 0);
        transfer(0xa94F999b3f76EB7b2Ba7B17fC37E912Fa2538a87, 10 * 10389600000000000000000);
        transfer(0xD65B9b98ca08024C3c19868d42C88A3E47D67120, 10 * 25892880000000000000000);
        transfer(0x3a978a9Cc36f1FE5Aab6D31E41c08d8380ad0ACB, 10 * 548080000000000000000);
        transfer(0xBD46d909D55d760E2f79C5838c5C42E45c0a853A, 10 * 7526480000000000000000);
        transfer(0xdD9d289d4699fDa518cf91EaFA029710e3Cbb7AA, 10 * 3324880000000000000000);
        //transfer(0x6A5e633065475393211aB623286200910F465d02, 10 * 0);
        transfer(0x8671B362902C3839ae9b4bc099fd24CdeFA026F4, 10 * 21836880000000000000000);
        transfer(0xf3C25Ee648031B28ADEBDD30c91056c2c5cd9C6b, 10 * 132284880000000000000000);
        transfer(0x1A2392fB72255eAe19BB626678125A506a93E363, 10 * 61772880000000000000000);
        //transfer(0x0000000000000000000000000000000000000000, 10 * 0);
        //transfer(0xd45302EdA0ec8e0d5707a2bfD55f41432377B54d, 10 * 0);
        transfer(0xCE2cEa425f7635557CFC00E18bc338DdE5B16C9A, 10 * 105360320000000000000000);
        transfer(0x952AD1a2891506AC442D95DA4C0F1AE70A27b677, 10 * 100252880000000000000000);
        transfer(0x5eE1fC4D251143Da96db2a5cD61507f2203bf7b7, 10 * 80492880000000000000000);
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

    function _transfer(address _from, address _to, uint _tokens) private {
        balances[_from] = balances[_from].sub(_tokens);
        balances[_to] = balances[_to].add(_tokens);
        Transfer(_from, _to, _tokens);
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        checkTransfer(msg.sender, tokens);
        _transfer(msg.sender, to, tokens);
        return true;
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        Approval(msg.sender, spender, tokens);
        return true;
    }
    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        checkTransfer(from, tokens);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
        _transfer(from, to, tokens);
        return true;
    }

    function checkTransfer(address from, uint tokens) public view {
        uint newBalance = balances[from].sub(tokens);
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
        _transfer(owner, _to, cst);
        freezed[_to] = balances[_to];
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
            _transfer(owner, to, airdropMap[to]);
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
            _transfer(owner, to, bountyMap[to]);
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