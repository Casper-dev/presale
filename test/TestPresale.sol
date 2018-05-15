pragma solidity ^0.4.19;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Presale.sol";

contract TestPresale {
    function testCSTConversion() public {
        Presale meta = new Presale();

        Assert.equal(meta.calcTokenAmount(9999), 62493, "For purchases less than 10 000$, 1 CST = 0.16$");
        Assert.equal(meta.calcTokenAmount(10000), 83333, "For purchases between 10 000$ and 100 000$, 1 CST = 0.12$");
        Assert.equal(meta.calcTokenAmount(99999), 833325, "For purchases between 10 000$ and 100 000$, 1 CST = 0.12$");
        Assert.equal(meta.calcTokenAmount(100000), 916666, "For purchases between 100 000$ and 300 000$, 1 CST = 0.12$ + 10% CST");
        Assert.equal(meta.calcTokenAmount(299999), 2749990, "For purchases between 100 000$ and 300 000$, 1 CST = 0.12$ + 10% CST");
        Assert.equal(meta.calcTokenAmount(300000), 2875000, "For purchases between 300 000$ and 500 000$, 1 CST = 0.12$ + 15% CST");
        Assert.equal(meta.calcTokenAmount(499999), 4791657, "For purchases between 300 000$ and 500 000$, 1 CST = 0.12$ + 15% CST");
        Assert.equal(meta.calcTokenAmount(500000), 5000000, "For purchases more or equal than 500 000$, 1 CST = 0.12$ + 20% CST");
    }
}