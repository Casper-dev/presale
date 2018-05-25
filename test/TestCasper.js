var Casper = artifacts.require('CasperToken')

const setTime = time => {
  var ts = web3.eth.getBlock(web3.eth.blockNumber).timestamp
  return web3.currentProvider.send({
    jsonrpc: '2.0',
    method: 'evm_increaseTime',
    params: [time - ts],
    id: 0
  })
}
const presaleStart = Date.parse('10 Jun 2018 00:00:00 GMT') / 1000
const presaleEnd = Date.parse('22 Jul 2018 23:59:59 GMT') / 1000
const crowdEnd = Date.parse('02 Aug 2018 23:59:59 GMT') / 1000
const crowdHard = Date.parse('16 Aug 2018 23:59:59 GMT') / 1000

contract('CasperToken', function (accounts) {
  var owner = accounts[0]
  var rate = 10 ** 12 // 1 ETH == 10^4

  it('should not allow ETH purchases equivalent to less than 10000$', function () {
    var wei = 10 ** 17
    var meta
    var client = accounts[1]
    return Casper.new()
      .then(function (instance) { meta = instance; return meta })
      .then(function () { return setTime(presaleStart) })
      .then(function () { return meta.setETHRate(rate) })
      .then(function () { return meta.unpause() })
      .then(function () { return meta.purchaseWithETH(client, {from: client, value: wei}) })
      .then(
        function (r) { assert(false, 'should have failed') },
        function (e) { }
      )
  })

  it('should allow ETH purchases equivalent more or equal than 10000$', function () {
    var wei = 10 ** 18 // 1 ETH
    var meta
    var client = accounts[2]
    var ownerBalance, clientBalance

    return Casper.new()
      .then(function (instance) {
        meta = instance
        return meta.setETHRate(rate)
      })
      .then(function () { return meta.unpause() })
      .then(function () {
        ownerBalance = web3.eth.getBalance(owner)
        clientBalance = web3.eth.getBalance(client)
      })
      .then(function () { return meta.purchaseWithETH(client, {from: client, value: wei}) })
      .then(function (resp) {
        var diff = web3.eth.getBalance(owner).sub(ownerBalance).toNumber()
        assert.equal(diff, wei, 'owner balance must increase')

        var gasUsed = web3.eth.getTransactionReceipt(resp.tx).cumulativeGasUsed
        var gasPrice = web3.eth.getTransaction(resp.tx).gasPrice
        diff = clientBalance.sub(web3.eth.getBalance(client)).toNumber()
        assert.equal(diff, wei + gasUsed * gasPrice, 'client balance must decrease')
      })
  })

  it('should not allow ETH purchases when contract is preSale is paused', function () {
    var wei = 10 ** 18
    var meta
    var client = accounts[2]

    return Casper.new()
      .then(function (instance) {
        meta = instance
        return meta.setETHRate(rate)
      })
      .then(function () { return meta.purchaseWithETH(client, {from: client, value: wei}) })
      .then(
        function (r) { assert(false, 'should have failed') },
        function (e) {}
      )
  })

  it('only owner should be able to change ETH and BTC rate', function () {
    var notOwner = accounts[1]

    return Casper.new()
      .then(function (instance) { return instance.setETHRate(rate, {from: notOwner}) })
      .then(
        function (r) { assert(false, 'should have failed') },
        function (e) {}
      )
  })
})
