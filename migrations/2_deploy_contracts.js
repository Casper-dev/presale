const Adviser = artifacts.require('./AdviserCasperToken.sol')
const Presale = artifacts.require('./Presale.sol')

module.exports = function (deployer) {
  deployer.deploy(Adviser)
  deployer.deploy(Presale)
}
