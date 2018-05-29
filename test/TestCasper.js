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
const unlock1 = Date.parse('28 Sep 2018 23:59:59 GMT') / 1000
const unlock2 = Date.parse('30 Nov 2018 23:59:59 GMT') / 1000
const unlock3 = Date.parse('31 Jan 2019 23:59:59 GMT') / 1000
const unlock4 = Date.parse('31 Mar 2019 23:59:59 GMT') / 1000
const unlock5 = Date.parse('31 May 2019 23:59:59 GMT') / 1000

contract('CasperToken', function (accounts) {
  var owner = accounts[0]
  var rate = 10 ** 12 // 1 ETH == 10^4

  it('should not allow ETH purchases equivalent to less than 10000$', function () {
    var wei = 10 ** 17
    var meta
    var last = false
    var client = accounts[1]
    return Casper.new()
      .then(function (instance) { meta = instance; return meta })
      .then(function () { return setTime(presaleStart) })
      .then(function () { return meta.setETHRate(rate) })
      .then(function () { last = true; return meta.purchaseWithETH(client, {from: client, value: wei}) })
      .then(
        function (r) { assert(false, 'should have failed') },
        function (e) {
          if (!last) {
            console.log(e)
            assert(false, 'error should occur on last step')
          };
        }
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

  it('only owner should be able to change ETH and BTC rate', function () {
    var notOwner = accounts[1]

    return Casper.new()
      .then(function (instance) { return instance.setETHRate(rate, {from: notOwner}) })
      .then(
        function (r) { assert(false, 'should have failed') },
        function (e) {}
      )
  })

  // this test is so big, because evm_increaseTime operates on VM state,
  // not contract and we do not want to impose any particular order on test execution.
  // So this test goes through all stage of ICO at once.
  it('should unfreeze tokens in proper date', function () {
    var meta
    var last = false
    var wei = 10 ** 18 // 1 ETH
    var from = accounts[1]
    var to = accounts[2]
    var normal = accounts[3]
    var slowpoke = accounts[4]
    var hyperslowpoke = accounts[5]
    var balance

    var lastError = function (e) {
      if (!last) {
        console.log(e)
        assert(false, 'error should occur on last step')
      };
      last = false
    }

    return Casper.new()
      .then(function (instance) {
        meta = instance
        return meta.setETHRate(rate)
      })
      .then(function () { setTime(presaleStart) })
      .then(function () { return meta.purchaseWithETH(from, {from: from, value: wei}) })
      .then(function () { return meta.balanceOf(from) })
      .then(function (b) { balance = b })
      .then(function () { setTime(presaleEnd + 10) })
      .then(function () { return meta.purchaseWithETH(normal, {from: normal, value: wei}) })
      .then(function () { setTime(crowdEnd + 10) })
      .then(function () { last = true; return meta.purchaseWithETH(slowpoke, {from: slowpoke, value: wei}) })
      .then(
        function (r) { assert(false, 'slowpoke should be unable to purchase after end of crowd-sale') },
        lastError
      )
      .then(function () { return meta.prolongCrowdsale() })
      .then(function () { return meta.purchaseWithETH(slowpoke, {from: slowpoke, value: wei}) })
      .then(function () { setTime(crowdHard + 10) })
      .then(function () { last = true; return meta.purchaseWithETH(hyperslowpoke, {from: hyperslowpoke, value: wei}) })
      .then(
        function (r) { assert(false, 'hyperslowpoke should be unable to purchase after hard-end of crowd-sale') },
        lastError
      )
      .then(function () { setTime(unlock1 - 10) })
      .then(function () { last = true; return meta.transfer(to, 1, {from: from}) })
      .then(
        function (r) { assert(false, 'transfer before 1st unlock should have failed') },
        lastError
      )
      .then(function () { setTime(unlock2 - 10) })
      .then(function () { return meta.transfer(to, balance.mul(0.2), {from: from}) })
      .then(function () { last = true; return meta.transfer(to, 2, {from: from}) })
      .then(
        function (r) { assert(false, 'transfer of more than unfreezed tokens should have failed') },
        lastError
      )
      .then(function () { setTime(unlock3 - 10) })
      .then(function () { return meta.transfer(to, balance.mul(0.2), {from: from}) })
      .then(function () { last = true; return meta.transfer(to, 4, {from: from}) })
      .then(
        function (r) { assert(false, 'transfer of more than unfreezed tokens should have failed') },
        lastError
      )
      .then(function () { setTime(unlock4 - 10) })
      .then(function () { return meta.transfer(to, balance.mul(0.2), {from: from}) })
      .then(function () { last = true; return meta.transfer(to, 6, {from: from}) })
      .then(
        function (r) { assert(false, 'transfer of more than unfreezed tokens should have failed') },
        lastError
      )
      .then(function () { setTime(unlock5 - 10) })
      .then(function () { return meta.transfer(to, balance.mul(0.2), {from: from}) })
      .then(function () { last = true; return meta.transfer(to, 8, {from: from}) })
      .then(
        function (r) { assert(false, 'transfer of more than unfreezed tokens should have failed') },
        lastError
      )
      .then(function () { setTime(unlock5 + 10) })
      .then(function () { return meta.balanceOf(from) })
      .then(function (b) { return meta.transfer(to, b, {from: from}) })
      .then(function () { return meta.balanceOf(to) })
      .then(function (b) { assert(b.equals(balance), 'all tokens must be transfered this moment') })
  })
})
