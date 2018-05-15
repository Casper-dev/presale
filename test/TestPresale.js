var Presale = artifacts.require("Presale");

contract('Presale', function(accounts) {
  it("should not allow ETH purchases equivalent to less than 10000$", function() {
    return Presale.deployed().then(function(instance) {
        instance.setETHRate(1000000000000000);
        instance.unpause();
        instance.purchaseWithETH(0, 1);
    })
    .then(function(r) {
        assert(false, 'purchase with less than 10000$ should have failed');
    });
  });
});