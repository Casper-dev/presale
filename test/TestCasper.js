var Casper = artifacts.require('CasperToken')

function setTime(time) {
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
  const owner = accounts[0]
  const rate = 10 ** 12 // 1 ETH == 10^4 $

  it('should not allow ETH purchases equivalent to less than 10000$', function () {
    var meta
    var last = false

    const wei = 10 ** 17
    const client = accounts[1]

    return Casper.new()
      .then(instance => { meta = instance; return meta })
      .then(() => { return setTime(presaleStart) })
      .then(() => { return meta.setETHRate(rate) })
      .then(() => { last = true; return meta.purchaseWithETH(client, {from: client, value: wei}) })
      .then(
        () => { assert(false, 'should have failed') },
        e  => {
          if (!last) {
            console.log(e)
            assert(false, 'error should occur on last step')
          };
        }
      )
  })

  it('should allow ETH purchases equivalent more or equal than 10000$', function () {
    var meta
    var ownerBalance, clientBalance

    const client = accounts[2]
    const wei = 10 ** 18 // 1 ETH

    return Casper.new()
      .then(inst => { meta = inst; return meta.setETHRate(rate) })
      .then(() => {
        ownerBalance = web3.eth.getBalance(owner)
        clientBalance = web3.eth.getBalance(client)
      })
      .then(() => { return meta.purchaseWithETH(client, {from: client, value: wei}) })
      .then(resp => {
        var diff = web3.eth.getBalance(owner).sub(ownerBalance).toNumber()
        assert.equal(diff, wei, 'owner balance must increase')

        var gasUsed = web3.eth.getTransactionReceipt(resp.tx).cumulativeGasUsed
        var gasPrice = web3.eth.getTransaction(resp.tx).gasPrice
        diff = clientBalance.sub(web3.eth.getBalance(client)).toNumber()
        assert.equal(diff, wei + gasUsed * gasPrice, 'client balance must decrease')
      })
  })

  it('only owner should be able to change ETH and BTC rate', function () {
    const notOwner = accounts[1]

    return Casper.new()
      .then(instance => { return instance.setETHRate(rate, {from: notOwner}) })
      .then(
        () => { assert(false, 'should have failed') },
        () => {}
      )
  })

  // this test is so big, because evm_increaseTime operates on VM state,
  // not contract and we do not want to impose any particular order on test execution.
  // So this test goes through all stage of ICO at once.
  it('should unfreeze tokens in proper date', function () {
    var meta
    var last = false
    var balance

    const wei = 10 ** 18 // 1 ETH
    const [, from, from2, to, normal, slowpoke, hyperslowpoke, bigInvestor] = accounts
    const bigInvestorBonus = web3.toBigNumber(4800000)
    function lastError(e) {
      if (!last) {
        console.log(e)
        assert(false, 'error should occur on last step')
      };
      last = false
    }

    return Casper.new()
      .then(inst => { meta = inst; return meta.setETHRate(rate) })
      .then(() => { setTime(presaleStart) })
      .then(() => { return meta.purchaseWithETH(from, {from: from, value: wei}) })
      .then(() => { last = true; return meta.transferBonus(bigInvestor, bigInvestorBonus) })
      .then(
        r => { assert(false, '4.8M$ purchase should have failed before we collected another 4.8$') },
        lastError
      )
      .then(() => { return meta.setETHRate(rate * 1000) }) // only to send 4.8$ from one account
      .then(() => { return meta.purchaseWithETH(from2, {from: from2, value: web3.toWei(1, 'ether')}) })
      .then(() => { return meta.setETHRate(rate) })
      .then(() => { return meta.transferBonus(bigInvestor, bigInvestorBonus) })
      .then(() => { return meta.setETHRate(rate) })
      .then(() => { return meta.balanceOf(from) })
      .then(b  => { balance = b })
      .then(() => { setTime(presaleEnd + 10) })
      .then(() => { return meta.purchaseWithETH(normal, {from: normal, value: wei}) })
      .then(() => { setTime(crowdEnd + 10) })
      .then(() => { last = true; return meta.purchaseWithETH(slowpoke, {from: slowpoke, value: wei}) })
      .then(
        () => { assert(false, 'slowpoke should be unable to purchase after end of crowd-sale') },
        lastError
      )
      .then(() => { return meta.prolongCrowdsale() })
      .then(() => { return meta.purchaseWithETH(slowpoke, {from: slowpoke, value: wei}) })
      .then(() => { setTime(crowdHard + 10) })
      .then(() => { last = true; return meta.purchaseWithETH(hyperslowpoke, {from: hyperslowpoke, value: wei}) })
      .then(
        () => { assert(false, 'hyperslowpoke should be unable to purchase after hard-end of crowd-sale') },
        lastError
      )
      .then(() => { setTime(unlock1 - 10) })
      .then(() => { last = true; return meta.transfer(to, 1, {from: from}) })
      .then(
        () => { assert(false, 'transfer before 1st unlock should have failed') },
        lastError
      )
      .then(() => { setTime(unlock2 - 10) })
      .then(() => { return meta.transfer(to, balance.mul(0.2), {from: from}) })
      .then(() => { last = true; return meta.transfer(to, 2, {from: from}) })
      .then(
        () => { assert(false, 'transfer of more than unfreezed tokens should have failed') },
        lastError
      )
      .then(() => { setTime(unlock3 - 10) })
      .then(() => { return meta.transfer(to, balance.mul(0.2), {from: from}) })
      .then(() => { last = true; return meta.transfer(to, 4, {from: from}) })
      .then(
        () => { assert(false, 'transfer of more than unfreezed tokens should have failed') },
        lastError
      )
      .then(() => { setTime(unlock4 - 10) })
      .then(() => { return meta.transfer(to, balance.mul(0.2), {from: from}) })
      .then(() => { last = true; return meta.transfer(to, 6, {from: from}) })
      .then(
        () => { assert(false, 'transfer of more than unfreezed tokens should have failed') },
        lastError
      )
      .then(() => { setTime(unlock5 - 10) })
      .then(() => { return meta.transfer(to, balance.mul(0.2), {from: from}) })
      .then(() => { last = true; return meta.transfer(to, 8, {from: from}) })
      .then(
        () => { assert(false, 'transfer of more than unfreezed tokens should have failed') },
        lastError
      )
      .then(() => { setTime(unlock5 + 10) })
      .then(() => { return meta.balanceOf(from) })
      .then(b  => { return meta.transfer(to, b, {from: from}) })
      .then(b  => { return meta.balanceOf(to) })
      .then(b  => { assert(b.equals(balance), 'all tokens must be transfered this moment') })
  })
})
