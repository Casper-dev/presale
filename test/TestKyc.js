var Casper = artifacts.require('CasperToken')
var c = require('./lib/common.js')

contract('CasperToken', function (accounts) {
  const rate = 10 ** 12 // 1 ETH == 10^4 $

  it('Purchasing should be forbidden for users without KYC mark', async function () {
    c.revert()

    const admin = accounts[1]
    const notOwner = accounts[2]
    const meta = await Casper.new()

    // Presale starts
    c.setTime(c.presaleStart + 10)

    // Admin sets ETHrate
    await meta.setAdmin(admin)
    await meta.setETHRate(rate, {from:admin})
    await meta.setBTCRate(rate, {from:admin})

    var value = web3.toWei(12, 'ether')

    // Random investor tries to purchase with purchaseWithETH
    var ok = await c.error(meta.purchaseWithETH(notOwner, {from: notOwner, value: value}))
    assert(ok, 'purchaseWithETH should be reverted for investor without KYC')

    // Random investor tries to purchase with promoter
    ok = await c.error(meta.purchaseWithPromoter(notOwner, notOwner, {from: notOwner, value: value}))
    assert(ok, 'purchaseWithPromoter should be reverted for investor without KYC')

    // Random investor tries to purchase with BTC
    ok = await c.error(meta.purchaseWithBTC(notOwner, 12 * (10 ** 8), value, {from: admin}))
    assert(ok, 'purchaseWithBTC should be reverted for investor without KYC')
  })
})