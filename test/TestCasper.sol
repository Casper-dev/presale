pragma solidity ^0.4.19;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CasperToken.sol";

contract TestCasper {
    function dollarsToMicroCSP(uint _dollars) public pure returns (uint) {
        return (uint(10) ** 18) * _dollars * 100 / 12;
    }

    // mainly to avoid typos in main contract if anything will change
    function testConstants() public {
        CasperToken meta = new CasperToken();

        uint total = meta.preICOSupply() + meta.presaleSupply() + meta.crowdsaleSupply();
        total += meta.systemSupply() + meta.investorSupply() + meta.teamSupply();
        total += meta.adviserSupply() + meta.bountySupply() + meta.referralSupply();
        Assert.equal(meta._totalSupply(), total, "Total supply must be equal to the sum of all supplies");

        Assert.isBelow(meta.presaleStartTime(), meta.crowdsaleStartTime(), "Presale must end after it starts.");
        Assert.isBelow(meta.crowdsaleStartTime(), meta.crowdsaleEndTime(), "Crowd-sale must end after it starts.");
        Assert.isBelow(meta.crowdsaleEndTime(), meta.crowdsaleHardEndTime(), "Crowd-sale hard-end time must happen after soft-end");
    }

    function testCalcBonus() public {
        CasperToken meta = new CasperToken();
        
        uint amount = dollarsToMicroCSP(10000);
        Assert.equal(meta.calcBonus(amount), amount, "For purchases between 10 000$ and 50 000$ no bonuses are applied.");

        amount = dollarsToMicroCSP(49999);
        Assert.equal(meta.calcBonus(amount), amount, "For purchases between 10 000$ and 50 000$ no bonuses are applied.");

        amount = dollarsToMicroCSP(50000);
        Assert.equal(meta.calcBonus(amount), amount * 105 / 100, "For purchases between 50 000$ and 100 000$, 5% bonus is applied");

        amount = dollarsToMicroCSP(99999);
        Assert.equal(meta.calcBonus(amount), amount * 105 / 100, "For purchases between 50 000$ and 100 000$, 5% bonus is applied");

        amount = dollarsToMicroCSP(100000);
        Assert.equal(meta.calcBonus(amount), amount * 110 / 100, "For purchases between 100 000$ and 300 000$, 10% bonus is applied");

        amount = dollarsToMicroCSP(299999);
        Assert.equal(meta.calcBonus(amount), amount * 110 / 100, "For purchases between 100 000$ and 300 000$, 10% bonus is applied");

        amount = dollarsToMicroCSP(300000);
        Assert.equal(meta.calcBonus(amount), amount * 115 / 100, "For purchases between 300 000$ and 500 000$, 15% bonus is applied");

        amount = dollarsToMicroCSP(499999);
        Assert.equal(meta.calcBonus(amount), amount * 115 / 100, "For purchases between 300 000$ and 500 000$,  15% bonus is applied");

        amount = dollarsToMicroCSP(500000);
        Assert.equal(meta.calcBonus(amount), amount * 120 / 100, "For purchases more or equal than 500 000$, 20% bonus is applied");
    }
}