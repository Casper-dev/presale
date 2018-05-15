var Presale = artifacts.require("Presale");

contract('Presale', function(accounts) {
    it("should not allow ETH purchases equivalent to less than 10000$", function() {
        var meta
        return Presale.new().then(function(instance) {
            meta = instance;
            return meta.setETHRate(1000000000000);
        })
        .then(function(){return meta.unpause();})
        .then(function(){return meta.purchaseWithETH(0, 10 ** 17);})
        .then(
            function(r) {assert(false, 'should have failed');},
            function(e) {}
        );
    });

    it("should allow ETH purchases equivalent more or equal than 10000$", function() {
        var meta
        return Presale.new().then(function(instance) {
            meta = instance;
            return meta.setETHRate(1000000000000);
        })
        .then(function(){return meta.unpause();})
        .then(function(){return meta.purchaseWithETH(0, 10 ** 18);});
    });
});