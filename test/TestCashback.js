var Casper = artifacts.require('CasperToken')
var c = require('./lib/common.js')

contract('CasperToken', function (accounts) {
  const rate = 10 ** 12 // 1 ETH == 10^4 $

  it('should return ETH to investor after calling cashBack', async function () {
    c.revert()

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
    var actualBalance = web3.eth.getBalance(notOwner)
    var expectedBalance = balance - gasCost
    var ok = newBalance == expectedBalance
    assert(ok, `expected: ${expectedBalance} got: ${actualBalance}`)
  })
})