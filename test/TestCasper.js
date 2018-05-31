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
async function error(promise) {
  return promise.then(data => false, err  => true);
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

  it('should not allow ETH purchases equivalent to less than 10000$', async function () {
    var last = false
    var ok

    const wei = 10 ** 17
    const client = accounts[1]

    const meta = await Casper.new()

    setTime(presaleStart)
    await meta.setETHRate(rate)
    ok = await error(meta.purchaseWithETH(client, {from: client, value: wei}))
    assert(ok, 'should have failed')
  })

  it('should allow ETH purchases equivalent more or equal than 10000$', async function () {
    var ownerBalance, clientBalance
    var resp, diff, gasUsed, gasPrice

    const wei = 10 ** 18 // 1 ETH
    const client = accounts[2]

    const meta = await Casper.new()
    await meta.setETHRate(rate)

    ownerBalance = web3.eth.getBalance(owner)
    clientBalance = web3.eth.getBalance(client)
    resp = await meta.purchaseWithETH(client, {from: client, value: wei})
    diff = web3.eth.getBalance(owner).sub(ownerBalance)
    assert(diff.equals(wei), 'owner balance must increase')
    
    gasUsed = web3.eth.getTransactionReceipt(resp.tx).cumulativeGasUsed
    gasPrice = web3.eth.getTransaction(resp.tx).gasPrice
    diff = clientBalance.sub(web3.eth.getBalance(client))
    assert(diff.equals(wei + gasUsed * gasPrice), 'client balance must decrease')
  })

  it('only owner or admin should be able to change ETH and BTC rate', async function () {
    const notOwner = accounts[1]
    const meta = await Casper.new()

    let ok = await error(meta.setETHRate(rate, {from: notOwner}))
    assert(ok, 'should have failed')
    await meta.setAdmin(notOwner);
    await meta.setETHRate(rate, {from: notOwner})
  })

  // this test is so big, because evm_increaseTime operates on VM state,
  // not contract and we do not want to impose any particular order on test execution.
  // So this test goes through all stage of ICO at once.
  it('should unfreeze tokens in proper date', async function () {
    var last = false
    var balance, ok

    const wei = 10 ** 18 // 1 ETH
    const [, from, from2, to, normal, slowpoke, hyperslowpoke, bigInvestor, air1, air2] = accounts
    const airCST = web3.toBigNumber(10 ** 18).mul(10) // 10 CST
    const bigInvestorBonus = web3.toBigNumber(4800000)

    const meta = await Casper.new()
    await meta.assignPreicoTokens()
    await meta.assignTeamTokens()
    await meta.setETHRate(rate)
    setTime(presaleStart)

    await meta.purchaseWithETH(from, {from: from, value: wei})

    ok = await error(meta.transferBonus(bigInvestor, bigInvestorBonus))
    assert(ok, '4.8M$ purchase should have failed before we collected another 4.8$')

    await meta.setETHRate(rate * 1000) // only to send 4.8$ from one account
    await meta.purchaseWithETH(from2, {from: from2, value: web3.toWei(1, 'ether')})
    await meta.setETHRate(rate)
    await meta.transferBonus(bigInvestor, bigInvestorBonus)
    balance = await meta.balanceOf(from)

    setTime(presaleEnd + 10)
    await meta.purchaseWithETH(normal, {from: normal, value: wei})
    await meta.doAirdrop([air1, air2], [airCST, airCST])
    assert(airCST.equals(await meta.balanceOf(air1)), "after airdrop balance should increase")
    assert(airCST.equals(await meta.balanceOf(air2)), "after airdrop balance should increase")

    setTime(crowdEnd + 10)
    ok = await error(meta.purchaseWithETH(slowpoke, {from: slowpoke, value: wei}))
    assert(ok, 'slowpoke should be unable to purchase after end of crowd-sale')

    await meta.prolongCrowdsale()
    await meta.purchaseWithETH(slowpoke, {from: slowpoke, value: wei})

    setTime(crowdHard + 10)
    ok = await error(meta.purchaseWithETH(hyperslowpoke, {from: hyperslowpoke, value: wei}))
    assert(ok, 'hyperslowpoke should be unable to purchase after hard-end of crowd-sale')

    setTime(unlock1 - 10)
    ok = await error(meta.transfer(to, 1, {from: from}))
    assert(ok, 'transfer before 1st unlock should have failed')

    setTime(unlock2 - 10)
    ok = await error(meta.transfer(to, balance.mul(0.2), {from: from}))
    assert(ok, 'transfer without KYC should have failed ')
    await meta.kycPassed(from);
    await meta.transfer(to, balance.mul(0.2), {from: from})
    ok = await error(meta.transfer(to, 2, {from: from}))
    assert(ok, 'transfer of more than unfreezed tokens should have failed')

    setTime(unlock3 - 10)
    await meta.transfer(to, balance.mul(0.2), {from: from})
    ok = await error(meta.transfer(to, 4, {from: from}))
    assert(ok, 'transfer of more than unfreezed tokens should have failed')

    setTime(unlock4 - 10)
    await meta.transfer(to, balance.mul(0.2), {from: from})
    ok = await error(meta.transfer(to, 6, {from: from}))
    assert(ok, 'transfer of more than unfreezed tokens should have failed')

    setTime(unlock5 - 10)
    await meta.transfer(to, balance.mul(0.2), {from: from})
    ok = await error(meta.transfer(to, 8, {from: from}))
    assert(ok, 'transfer of more than unfreezed tokens should have failed')

    setTime(unlock5 + 10)
    await meta.transfer(to, await meta.balanceOf(from), {from: from})
    assert(balance.equals(await meta.balanceOf(to)), 'all tokens must be transfered this moment')

  })
})
