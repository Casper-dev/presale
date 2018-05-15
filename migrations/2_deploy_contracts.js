const Presale = artifacts.require("./Presale.sol")

module.exports = function(deployer) {
	deployer.deploy(Presale);
};
