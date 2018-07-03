var Casper = artifacts.require('CasperToken')
var c = require('./lib/common.js')

contract('CasperToken', function (accounts) {
  const rate = 10 ** 14 // 1 ETH == 10^6 $

  const admin = accounts[1]
  const wuguFirst = accounts[2]
  const wuguSecond = accounts[3]

  const wugu = '0x096ad02a48338CB9eA967a96062842891D195Af5'

  it('should give Wugu 5% of every referal payment', async function() {
    const meta = await Casper.deployed()

    // Presale starts
    c.setTime(c.presaleStart + 10)

    // Admin sets ETHrate
    await meta.setAdmin(admin)
    await meta.setETHRate(rate, {from:admin})

    // Owner assigns team and preico tokens
    await meta.assignPreicoTokens()
    await meta.assignTeamTokens()

    // Random investors passes KYC
    await meta.kycPassed(wuguFirst, wugu, {from:admin})
    await meta.kycPassed(wuguSecond, wugu, {from:admin})

    var value = web3.toBigNumber(web3.toWei(10, 'ether'))

    // Random investor pays 10 ether ($100k)
    await meta.purchaseWithPromoter(wuguFirst, wugu, {from:wuguFirst, value:value})

    // Another investor pays 10 ether
    await meta.purchaseWithETH(wuguSecond, {from:wuguSecond, value:value})

    // Wugu tries to withdraw bonuses
    web3.eth.sendTransaction({from:wuguFirst, to:wugu, value:value})
    var resp = await meta.withdrawPromoter({from:wugu})
    var gasCost = c.gasCostWei(resp.tx)
    
    // Wugu expects to receive 2 * (10 * 0.05) 
    var newBalance = web3.eth.getBalance(wugu)
    var expected = value.add(value.mul(5).div(100).mul(2)).sub(gasCost)
    var ok = newBalance.eq(expected)
    assert(ok, `Wugu expected: ${expected} but got ${newBalance}`)
  })
})