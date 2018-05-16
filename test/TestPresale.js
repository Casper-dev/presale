var Presale = artifacts.require("Presale");

contract('Presale', function(accounts) {
    var owner  = accounts[0];
    var rate = 10 ** 12; // 1 ETH == 10^4

    it("should not allow ETH purchases equivalent to less than 10000$", function() {
        var wei = 10 ** 17;
        var meta;
        var client = accounts[1];
        return Presale.new().then(function(instance) {
            meta = instance;
            return meta.setETHRate();
        })
        .then(function(){return meta.unpause(rate)})
        .then(function(){return meta.purchaseWithETH(client, {from:client,value:wei})})
        .then(
            function(r) {assert(false, 'should have failed')},
            function(e) {}
        );
    });

    it("should allow ETH purchases equivalent more or equal than 10000$", function() {
        var wei  = 10 ** 18; // 1 ETH
        var meta;
        var client = accounts[2];
        var ownerBalance, clientBalance;

        return Presale.new()
        .then(function(instance) {
            meta = instance;
            return meta.setETHRate(rate);
        })
        .then(function(){return meta.unpause();})
        .then(function(){
            ownerBalance = web3.eth.getBalance(owner);
            clientBalance = web3.eth.getBalance(client);
        })
        .then(function(){return meta.purchaseWithETH(client, {from:client,value:wei})})
        .then(function(resp){
            diff = web3.eth.getBalance(owner).sub(ownerBalance).toNumber();
            assert.equal(diff, wei, "owner balance must increase");

            var gasUsed = web3.eth.getTransactionReceipt(resp.tx).cumulativeGasUsed;
            var gasPrice = web3.eth.getTransaction(resp.tx).gasPrice;
            diff = clientBalance.sub(web3.eth.getBalance(client)).toNumber();
            assert.equal(diff, wei + gasUsed * gasPrice, "client balance must decrease");
        })
    });

    it("should not allow ETH purchases when contract is preSale is paused", function() {
        var wei = 10 ** 18;
        var meta;
        var client = accounts[2];

        return Presale.new()
        .then(function(instance) {
            meta = instance;
            return meta.setETHRate(rate);
        })
        .then(function(){return meta.purchaseWithETH(client, {from:client,value:wei})})
        .then(
            function(r) {assert(false, "should have failed")},
            function(e) {}
        )
    })
});