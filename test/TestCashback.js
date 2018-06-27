var Casper = artifacts.require('CasperToken')
var c = require('./common.js')

contract('CasperToken', function (accounts) {
  const owner = accounts[0]
  const rate = 10 ** 12 // 1 ETH == 10^4 $

  it('should return ETH to investor after calling cashBack', async function () {
    const admin = accounts[1]
    const notOwner = accounts[2]
    const meta = await Casper.new()

    // Remember notOwner's balance and create gas counter
    var balance = web3.eth.getBalance(notOwner)
    var gasCost = 0

    // Presale starts
    c.setTime(c.presaleStart + 10)

    // Admin sets ETHrate
    await meta.setAdmin(admin)
    await meta.setETHRate(rate, {from:admin})

    // Random investor passes KYC
    await meta.kycPassed(notOwner, notOwner, {from:admin})

    // Random investor makes a purchase with ETH (requires some gas)
    var value = web3.toWei(12, 'ether')
    var resp = await meta.purchaseWithETH(notOwner, {from: notOwner, value: value})
    gasCost += c.gasCostWei(resp.tx)

    // Crowdsale ends
    c.setTime(c.crowdEnd + 10)

    // Random investor tries to get cashback (requires some gas)
    resp = await meta.cashBack(notOwner, {from: notOwner})
    gasCost += c.gasCostWei(resp.tx)

    // Random investor expects his eth has been returned to his wallet
    var newBalance = web3.eth.getBalance(notOwner)
    var ok = newBalance == balance - gasCost
    assert(ok, 'ETH should be returned to investor after cashback')
  })
})