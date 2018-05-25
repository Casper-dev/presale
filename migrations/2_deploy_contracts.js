const Adviser = artifacts.require('./AdviserCasperToken.sol')
const Casper = artifacts.require('./CasperToken.sol')

module.exports = function (deployer) {
  deployer.deploy(Adviser)
  deployer.deploy(Casper)
}
