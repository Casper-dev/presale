pragma solidity 0.4.24;

import {SafeMath} from "./SafeMath.sol";
import {ERC20Interface} from "./ERC20Interface.sol";
import {Owned} from "./Owned.sol";

contract CasperToken is ERC20Interface, Owned {
    using SafeMath for uint;

    string public constant name = "Csper Token";
    string public constant symbol = "CST";
    uint8 public constant decimals = 18;

    uint constant public cstToMicro = uint(10) ** decimals;

    // This constants reflects CST token distribution
    uint constant public _totalSupply    = 440000000 * cstToMicro;
    uint constant public preICOSupply    = 13000000 * cstToMicro;
    uint constant public presaleSupply   = 183574716 * cstToMicro;
    uint constant public crowdsaleSupply = 19750000 * cstToMicro;
    uint constant public communitySupply = 66000000 * cstToMicro;
    uint constant public systemSupply    = 35210341 * cstToMicro;
    uint constant public investorSupply  = 36714943 * cstToMicro;
    uint constant public teamSupply      = 66000000 * cstToMicro;
    uint constant public adviserSupply   = 7000000 * cstToMicro;
    uint constant public bountySupply    = 8800000 * cstToMicro;
    uint constant public referralSupply  = 3950000 * cstToMicro;

    // This variables accumulate amount of sold CST during
    // presale, crowdsale, or given to investors as bonus.
    uint public presaleSold = 0;
    uint public crowdsaleSold = 0;
    uint public investorGiven = 0;

    // Amount of ETH received during ICO
    uint public ethSold = 0;

    uint constant public softcapUSD = 4800000;

    // Presale lower bound in dollars.
    uint constant public bonusLevel0 = cstToMicro * 10000 * 100 / 12; // 10000$
    uint constant public bonusLevel100 = cstToMicro * 100000 * 100 / 12; // 100000$

    // Tokens are unlocked in 5 stages, by 20% (see doc to checkTransfer)
    // All dates are stored as timestamps.
    uint constant public unlockDate1 = 1538179199; // 28.09.2018 23:59:59
    uint constant public unlockDate2 = 1543622399; // 30.11.2018 23:59:59
    uint constant public unlockDate3 = 1548979199; // 31.01.2019 23:59:59
    uint constant public unlockDate4 = 1553903999; // 29.03.2019 23:59:59
    uint constant public unlockDate5 = 1559347199; // 31.05.2019 23:59:59   

    //https://casperproject.atlassian.net/wiki/spaces/PROD/pages/277839878/Smart+contract+ICO
    // Presale 10.06.2018 - 22.07.2018
    // Crowd-sale 23.07.2018 - 2.08.2018 (16.08.2018)
    uint constant public presaleStartTime     = 1528588800;
    uint constant public crowdsaleStartTime   = 1532304000;
    uint          public crowdsaleEndTime     = 1533168000;
    uint constant public crowdsaleHardEndTime = 1534377600;
    //address constant CsperWallet = 0x6A5e633065475393211aB623286200910F465d02;
    constructor() public {
        admin = owner;
        balances[owner] = _totalSupply;
        emit Transfer(address(0), owner, _totalSupply);
    }

    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }

    modifier onlyOwnerAndDirector {
        require(msg.sender == owner || msg.sender == director);
        _;
    }

    address admin;
    function setAdmin(address _newAdmin) public onlyOwnerAndDirector {
        admin = _newAdmin;
    }

    address director;
    function setDirector(address _newDirector) public onlyOwner {
        director = _newDirector;
    }

    bool assignedPreico = false;
    /// @notice assignPreicoTokens transfers 10x tokens to pre-ICO participants
    function assignPreicoTokens() public onlyOwnerAndDirector {
        require(!assignedPreico);
        assignedPreico = true;

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

    bool assignedTeam = false;
    /// @notice assignTeamTokens assigns tokens to team members
    /// @notice tokens for team have their own supply
    function assignTeamTokens() public onlyOwnerAndDirector {
        require(!assignedTeam);
        assignedTeam = true;

        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
        transfer(0xb424958766e736827Be5A441bA2A54bEeF54fC7C, 100 * cstToMicro);
    }

    /// @nptice kycPassed is executed by backend and tells SC
    /// that particular client has passed KYC
    mapping(address => bool) public kyc;
    mapping(address => address) public referral;
    function kycPassed(address _mem, address _ref) public onlyAdmin {
        kyc[_mem] = true;
        if (_ref == richAddr || _ref == vukuAddr) {
            referral[_mem] = _ref;
        }
    }

    // mappings for implementing ERC20
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;

    // mapping for implementing unlock mechanic
    mapping(address => uint) freezed;

    // ERC20 standard functions
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
        emit Transfer(_from, _to, _tokens);
    }
    
    function transfer(address _to, uint _tokens) public returns (bool success) {
        checkTransfer(msg.sender, _tokens);
        _transfer(msg.sender, _to, _tokens);
        return true;
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        checkTransfer(from, tokens);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(tokens);
        _transfer(from, to, tokens);
        return true;
    }

    /// @notice checkTransfer ensures that `from` can send only unlocked tokens
    /// @notice this function is called for every transfer
    /// We unlock PURCHASED and BONUS tokens in 5 stages:
    /// after 28.09.2018 20% are unlocked
    /// after 30.11.2018 40% are unlocked
    /// after 31.01.2019 60% are unlocked
    /// after 29.03.2019 80% are unlocked
    /// after 31.05.2019 100% are unlocked
    /// All AIRDROP tokens are 100% unlocked after first stage.
    function checkTransfer(address from, uint tokens) public view {
        uint newBalance = balances[from].sub(tokens);
        if (now < unlockDate5 && from != owner) {
            require(now >= unlockDate1);
            if (now < unlockDate2) {
                // 20% of tokens are unlocked
                require(newBalance >= freezed[from].mul(80).div(100).add(airFreezed[from]));
            } else if (now < unlockDate3) {
                // 40% of tokens are unlocked
                require(newBalance >= freezed[from].mul(60).div(100).add(airFreezed[from]));
            } else if (now < unlockDate4) {
                // 60% of tokens are unlocked
                require(newBalance >= freezed[from].mul(40).div(100).add(airFreezed[from]));
            } else {
                // 80% of tokens are unlocked
                require(newBalance >= freezed[from].mul(20).div(100).add(airFreezed[from]));
            }
        }
    }

    /// @return ($ received, ETH received, CST sold)
    function ICOStatus() public view returns (uint usd, uint eth, uint cst) {
        usd = presaleSold.mul(12).div(10**20) + crowdsaleSold.mul(16).div(10**20);
        usd = usd.add(1040000); // pre-ico tokens
        return (usd, ethSold, presaleSold + crowdsaleSold);
    }

    function checkICOStatus() public view returns(bool) {
        uint eth;
        uint cst;

        (, eth, cst) = ICOStatus();

        uint dollarsRecvd = eth.mul(ethRate).div(10**8);

        // 26 228 800$
        return dollarsRecvd >= 26228000 || (cst == presaleSupply + crowdsaleSupply) || now > crowdsaleEndTime;
    }

    bool icoClosed = false;
    function closeICO() public onlyOwnerAndDirector {
        icoClosed = checkICOStatus();
    }

    bool bonusTransfered = false;

    /// @notice by agreement, we can transfer $4.8M from bank
    /// after softcap is reached.
    /// @param _to wallet to send CST to
    /// @param  _usd amount of dollars which is withdrawn
    function transferBonus(address _to, uint _usd) public onlyOwner {
        require(!bonusTransfered);
        bonusTransfered = true;

        uint cst = _usd.mul(100).mul(cstToMicro).div(12); // presale tariff
        presaleSold = presaleSold.add(cst);
        ethSold = ethSold.add(_usd.mul(10**8).div(ethRate));

        _freezeTransfer(_to, cst);
    }

    /// @notice extend crowdsale for 2 weeks
    function prolongCrowdsale() public onlyOwnerAndDirector {
        crowdsaleEndTime = crowdsaleHardEndTime;
    }

    // 100 000 000 Ether in dollars
    uint public ethRate = 0;
    uint public ethRateMax = 0;
    uint public ethLastUpdate = 0;
    function setETHRate(uint _rate) public onlyAdmin {
        require(ethRateMax == 0 || ethRate < ethRateMax);
        ethRate = _rate;
        ethLastUpdate = now;
    }

    // 100 000 000 BTC in dollars
    uint public btcRate = 0;
    uint public btcRateMax = 0;
    uint public btcLastUpdate;
    function setBTCRate(uint _rate) public onlyAdmin {
        require(btcRateMax == 0 || btcRate < btcRateMax);
        btcRate = _rate;
        btcLastUpdate = now;
    }

    /// @notice setMaxRate sets max rate for both BTC/ETH to soften
    /// negative consequences in case our backend gots hacked.
    function setMaxRate(uint ethMax, uint btcMax) public {
        require(msg.sender == director || msg.sender == owner);
        ethRateMax = ethMax;
        btcRateMax = btcMax;
    }

    /// @notice _sellPresale checks CST purchases during crowdsale
    function _sellPresale(uint cst) private {
        require(cst >= bonusLevel0.mul(9997).div(10000));
        presaleSold = presaleSold.add(cst);
        require(presaleSold <= presaleSupply);
    }

    /// @notice _sellCrowd checks CST purchases during crowdsale
    function _sellCrowd(uint cst, address _to) private {
        crowdsaleSold = crowdsaleSold.add(cst);
        require(crowdsaleSold <= crowdsaleSupply.add(presaleSupply).sub(presaleSold));
        if (now < crowdsaleStartTime + 3 days) {
            if (whitemap[_to] >= cst) {
                whitemap[_to] -= cst;
                whitelistTokens -= cst;
            } else {
                require(crowdsaleSupply.add(presaleSupply).sub(presaleSold) >= crowdsaleSold.add(whitelistTokens).add(cst));
            }
        }
    }

    /// @notice addInvestorBonus is used for sending bonuses for big investors in %
    function addInvestorBonus(address _to, uint8 p) public onlyOwner {
        require(p > 0 && p <= 5);
        uint bonus = balances[_to].mul(p).div(100);

        investorGiven = investorGiven.add(bonus);
        require(investorGiven <= investorSupply);

        _freezeTransfer(_to, bonus);
    }
 
    /// @notice addPresaleBonus is used for sending bonuses for big investors in tokens
    function addPresaleBonus(address _to, uint tokens) public onlyOwnerAndDirector {
        _freezeTransfer(_to, tokens);
        
        investorGiven = investorGiven.add(tokens);
        require(investorGiven <= investorSupply);
    }

    function () payable public {
        purchaseWithETH(msg.sender);
    }

    /// @notice _freezeTranfer perform actual tokens transfer which
    /// will be freezed (see also checkTransfer() )
    function _freezeTransfer(address _to, uint cst) private {
        _transfer(owner, _to, cst);
        freezed[_to] = freezed[_to].add(cst);
    }

    address public constant vukuAddr = 0xaBa41bEC8bD59a8C14588C755447FEC08aa73C90;
    address public constant richAddr = 0x6A5e633065475393211aB623286200910F465d02;
    mapping(address => address[]) promoterClients;
    mapping(address => mapping(address => uint)) promoterBonus;

    /// @notice withdrawPromoter transfers back to promoter 
    /// all bonuses accumulated to current moment
    function withdrawPromoter() public {
        address _to = msg.sender;
        require(_to == vukuAddr || _to == richAddr);

        uint usd;
        (usd,,) = ICOStatus();

        // soft-cap + 5% is closed
        require(usd >= softcapUSD.mul(105).div(100));

        uint bonus = 0;
        address[] memory clients = promoterClients[_to];
        for(uint i = 0; i < clients.length; i++) {
            if (kyc[clients[i]]) {
                uint num = promoterBonus[_to][clients[i]];
                delete promoterBonus[_to][clients[i]];
                bonus += num;
            }
        }
        
        _to.transfer(bonus);
    }

    /// @notice cashBack will be used in case of failed ICO
    /// All partitipants can receive their ETH back
    function cashBack(address _to) public {
        uint usd;
        (usd,,) = ICOStatus();

        // ICO fails if crowd-sale is ended and we have not yet reached soft-cap
        require(now > crowdsaleEndTime && usd < softcapUSD);
        require(ethSent[_to] > 0);

        _to.transfer(ethSent[_to]);
    }

    /// @notice stores amount of ETH received by SC
    mapping(address => uint) ethSent;

    function purchaseWithETH(address _to) payable public {
        purchaseWithPromoter(_to, referral[msg.sender]);
    }

    /// @notice purchases tokens, which a send to `_to` with 5% returned to `_ref`
    /// @notice 5% return must work only on crowdsale
    function purchaseWithPromoter(address _to, address _ref) payable public {
        require(now >= presaleStartTime && now <= crowdsaleEndTime);

        require(!icoClosed);
    
        uint _wei = msg.value;
        uint cst;

        ethSent[msg.sender] = ethSent[msg.sender].add(_wei);
        ethSold = ethSold.add(_wei);

        // accept payment on presale only if it is more than 9997$
        // actual check is performed in _sellPresale
        if (now < crowdsaleStartTime || approvedInvestors[msg.sender]) {
            require(kyc[msg.sender]);
            cst = _wei.mul(ethRate).div(12000000); // 1 CST = 0.12 $ on presale

            require(now < crowdsaleStartTime || cst >= bonusLevel100);

            _sellPresale(cst);

            /// we have only 2 recognized promoters
            if (now < crowdsaleStartTime && _ref == vukuAddr || _ref == richAddr) {
                promoterClients[_ref].push(_to);
                promoterBonus[_ref][_to] = _wei.mul(5).div(100);
            }
        } else {
            cst = _wei.mul(ethRate).div(16000000); // 1 CST = 0.16 $ on crowd-sale
            _sellCrowd(cst, _to);
        }

        _freezeTransfer(_to, cst);
    }

    /// @notice purchaseWithBTC is called from backend, where we convert
    /// BTC to ETH, and then assign tokens to purchaser, using BTC / $ exchange rate.
    function purchaseWithBTC(address _to, uint _satoshi, uint _wei) public onlyAdmin {
        require(now >= presaleStartTime && now <= crowdsaleEndTime);

        require(!icoClosed);

        ethSold = ethSold.add(_wei);

        uint cst;
        // accept payment on presale only if it is more than 9997$
        // actual check is performed in _sellPresale
        if (now < crowdsaleStartTime || approvedInvestors[msg.sender]) {
            require(kyc[msg.sender]);
            cst = _satoshi.mul(btcRate.mul(10000)).div(12); // 1 CST = 0.12 $ on presale

            require(now < crowdsaleStartTime || cst >= bonusLevel100);

            _sellPresale(cst);
        } else {
            cst = _satoshi.mul(btcRate.mul(10000)).div(16); // 1 CST = 0.16 $ on presale
            _sellCrowd(cst, _to);
        }

        _freezeTransfer(_to, cst);
    }

    /// @notice withdrawFunds is called to send team bonuses after
    /// then end of the ICO
    function withdrawFunds(uint _wei) public onlyOwner {
        // TODO add time restrictions and ETH distribution
        // TODO not owner but multisig
        owner.transfer(_wei);
    }

    mapping(address => uint) airFreezed;
    /// @notice doAirdrop is called when we launch airdrop.
    /// @notice airdrop tokens has their own supply.
    function doAirdrop(address[] members, uint[] tokens) public onlyOwnerAndDirector {
        require(members.length == tokens.length);
        uint dropped = 0;
        for(uint i = 0; i < members.length; i++) {
            _transfer(owner, members[i], tokens[i]);
            // airdrop tokens have another unlock mechanic,
            // so we store them in separate map
            airFreezed[members[i]] = airFreezed[members[i]].add(tokens[i]);
            dropped = dropped.add(tokens[i]);
        }
        require(dropped < bountySupply);
    }

    mapping(address => uint) public whitemap;
    uint public whitelistTokens = 0;
    address[] public whiteList;
    /// @notice addWhitelistMember is used to whitelist participant.
    /// This means, that for the first 3 days of crowd-sale `_tokens` CST 
    /// will be reserved for him.
    function addWhitelistMember(address _mem, uint _tokens) public onlyAdmin {
        if (whitemap[_mem] == 0) {
            whiteList.push(_mem);
        }
        whitemap[_mem] = _tokens;
        whitelistTokens.add(_tokens);
    }

    uint public adviserSold = 0;
    /// @notice transferAdviser is called to send tokens to advisers.
    /// @notice adviser tokens have their own supply
    function transferAdviser(address[] _adv, uint[] _tokens) public onlyOwnerAndDirector {
        require(_adv.length == _tokens.length);
        for (uint i = 0; i < _adv.length; i++) {
            adviserSold = adviserSold.add(_tokens[i]);
            _freezeTransfer(_adv[i], _tokens[i]);
        }
        require(adviserSold <= adviserSupply);
    }

    mapping(address => bool) approvedInvestors;
    function approveInvestor(address _addr) public onlyOwner {
        approvedInvestors[_addr] = true;
    }
}