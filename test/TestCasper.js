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
const unlock4 = Date.parse('29 Mar 2019 23:59:59 GMT') / 1000
const unlock5 = Date.parse('31 May 2019 23:59:59 GMT') / 1000

contract('CasperToken', function (accounts) {
  const owner = accounts[0]
  const rate = 10 ** 12 // 1 ETH == 10^4 $

  it('only owner or admin should be able to change ETH and BTC rate', async function () {
    const notOwner = accounts[1]
    const meta = await Casper.new()

    var ok

    ok = await error(meta.setETHRate(rate, {from: notOwner}))
    assert(ok, 'only owner or admin can change ETH rate')

    ok = await error(meta.setBTCRate(rate, {from: notOwner}))
    assert(ok, 'only owner or admin can change BTC rate')

    await meta.setAdmin(notOwner);
    await meta.setETHRate(rate, {from: notOwner})
    await meta.setBTCRate(rate, {from: notOwner})
  })

  // this test is so big, because evm_increaseTime operates on VM state,
  // not contract and we do not want to impose any particular order on test execution.
  // So this test goes through all stage of ICO at once.
  it('should unfreeze tokens in proper date', async function () {
    var last = false
    var balance, ok

    const wei = web3.toWei(12, 'ether') // 12 ETH
    const [, admin, from, from2, to, normal, slowpoke, hyperslowpoke, bigInvestor, wuguClient, air1, air2] = accounts
    const airCST = web3.toBigNumber(10 ** 18).mul(10) // 10 CST
    const bigInvestorBonus = web3.toBigNumber(4800000)

    const meta = await Casper.new()
    
    // truffle must be run in network with this account
    // 101e95f9ef90e52adf32930908f01f53d34b1e04c9707d765de77760942d0441
    const wugu = '0xaba41bec8bd59a8c14588c755447fec08aa73c90'

    await meta.setAdmin(admin)

    await meta.assignPreicoTokens()
    await meta.assignTeamTokens()
    await meta.setETHRate(rate, {from:admin})
    setTime(presaleStart)

    await meta.kycPassed(from, from, {from:admin})

    ok = await error(meta.purchaseWithETH(from, {from: from, value: web3.toWei(0.5, 'ether')}))
    assert(ok, 'should not allow purchases smaller than $10k')

    await meta.purchaseWithETH(from, {from: from, value: wei})

    //ok = await error(meta.transferBonus(bigInvestor, bigInvestorBonus))
    //assert(ok, '4.8M$ purchase should have failed before we collected another 4.8$')

    await meta.kycPassed(wuguClient, wugu, {from:admin})
    await meta.purchaseWithETH(wuguClient, {from:wuguClient, value:wei})

    ok = await error(meta.withdrawPromoter({from:wugu}))
    assert(ok, "promoters cant withdraw before soft-cap is reached")

    await meta.setETHRate(rate * 1000, {from:admin}) // only to send 4.8$ from one account
    await meta.kycPassed(from2, from2, {from:admin})
    await meta.purchaseWithETH(from2, {from: from2, value: web3.toWei(1, 'ether')})
    await meta.setETHRate(rate, {from:admin})
    await meta.transferBonus(bigInvestor, bigInvestorBonus)

    setTime(presaleEnd + 10)

    balance = web3.eth.getBalance(wugu)
    bonus = web3.toBigNumber(wei).mul(5).div(100)
    resp = await meta.withdrawPromoter({from:wugu})

    gasUsed = web3.eth.getTransactionReceipt(resp.tx).cumulativeGasUsed
    gasPrice = web3.eth.getTransaction(resp.tx).gasPrice
    diff = web3.eth.getBalance(wugu).sub(balance)
    assert(diff.equals(bonus - gasUsed * gasPrice), 'wugu balance must increase properly')
    

    await meta.purchaseWithETH(normal, {from: normal, value: wei})
    await meta.doAirdrop([air1, air2], [airCST, airCST])
    assert(airCST.equals(await meta.balanceOf(air1)), "after airdrop balance should increase")
    assert(airCST.equals(await meta.balanceOf(air2)), "after airdrop balance should increase")

    setTime(crowdEnd + 10)
    ok = await error(meta.purchaseWithETH(slowpoke, {from: slowpoke, value: wei}))
    assert(ok, 'slowpoke should be unable to purchase after end of crowd-sale')

    ok = await error(meta.prolongCrowdsale())
    assert(ok, 'crowdsale can be prolonged only before ICO finish')

    setTime(unlock1 - 10)
    ok = await error(meta.transfer(to, 1, {from: from}))
    assert(ok, 'transfer before 1st unlock should have failed')

    setTime(unlock2 - 10)
    
    //ok = await error(meta.transfer(to, 1, {from: air1}))
    //assert(ok, 'transfer without KYC should have failed ')

    balance = await meta.balanceOf(from)

    let p20 = balance.div(5)
    await meta.transfer(to, p20, {from: from})
    ok = await error(meta.transfer(to, 2, {from: from}))
    assert(ok, 'transfer of more than unfreezed tokens should have failed')

    setTime(unlock3 - 10)
    await meta.transfer(to, p20, {from: from})
    ok = await error(meta.transfer(to, 4, {from: from}))
    assert(ok, 'transfer of more than unfreezed tokens should have failed')

    setTime(unlock4 - 10)
    await meta.transfer(to, p20, {from: from})
    ok = await error(meta.transfer(to, 6, {from: from}))
    assert(ok, 'transfer of more than unfreezed tokens should have failed')

    setTime(unlock5 - 10)
    await meta.transfer(to, p20, {from: from})
    ok = await error(meta.transfer(to, 8, {from: from}))
    assert(ok, 'transfer of more than unfreezed tokens should have failed')

    setTime(unlock5 + 10)
    await meta.transfer(to, await meta.balanceOf(from), {from: from})
    assert(balance.equals(await meta.balanceOf(to)), 'all tokens must be transfered this moment')

    balance = web3.eth.getBalance(owner)
    metab = web3.eth.getBalance(meta.address)
    resp = await meta.withdrawFunds(metab)
    gasUsed = web3.eth.getTransactionReceipt(resp.tx).cumulativeGasUsed
    gasPrice = web3.eth.getTransaction(resp.tx).gasPrice
    diff = web3.eth.getBalance(owner).sub(balance)
    assert(diff.equals(metab.mul(85).div(100) - gasUsed * gasPrice), 'owner balance must increase properly after withdrawal')
  })
})