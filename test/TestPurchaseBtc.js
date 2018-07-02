var Casper = artifacts.require('CasperToken')
var c = require('./lib/common.js')

contract('CasperToken', function (accounts) {
  const rate = 10 ** 12 // 1 ETH == 10^4 $
  const owner = accounts[0]

  const admin = accounts[1]
  const notOwner = accounts[2]
  const alsoNotOwner = accounts[3]

  const value = 12 * (10 ** 8) // 12 BTC
  const wei = value * (10 ** 10) // Same rate

  it('should revert purchase <$10k during presale', async function () {
    const meta = await Casper.deployed()

    // Presale starts
    c.setTime(c.presaleStart + 10)

    // Admin sets rates
    await meta.setAdmin(admin)
    await meta.setBTCRate(rate, {from:admin})
    await meta.setETHRate(rate, {from:admin})

    // Owner assigns team and preico tokens
    await meta.assignPreicoTokens()
    await meta.assignTeamTokens()

    // Random investor passes KYC
    await meta.kycPassed(notOwner, notOwner, {from:admin})
    await meta.kycPassed(alsoNotOwner, alsoNotOwner, {from:admin})

    // Meme
    await meta.kycPassed(admin, admin, {from:admin})

    // Random investor tries to pay <9950 usd
    var ok = await c.error(meta.purchaseWithBTC(notOwner, value/1000, wei/1000, {from:admin}))
    assert(ok, 'purchase was not reverted')
  })

  it('should pass purchase >$10k at a presale price', async function() {
    const meta = await Casper.deployed()

    // Random investor tries to pay 12 BTC (>$10k) and expects _wei.mul(ethRate).div(12000000) tokens
    await meta.purchaseWithBTC(notOwner, value, wei, {from:admin})
    var actualTokens = await meta.balanceOf(notOwner)
    var calculatedTokens = web3.toBigNumber(wei).mul(rate).div(12000000)

    // Actual and calculated tokens are of different precision
    // so we cant compare them directly
    // http://mikemcl.github.io/bignumber.js/#toFix
    // http://mikemcl.github.io/bignumber.js/#sd
    actualTokens = actualTokens.toFixed(0)
    calculatedTokens = calculatedTokens.toFixed(0)

    ok = actualTokens == calculatedTokens
    assert(ok, `expected: ${calculatedTokens} got: ${actualTokens}`)
  })

  it('should pass purchase >$10 at a crowdsale price when crowdsale starts', async function() {
    const meta = await Casper.deployed()

    // Crowdsale starts
    c.setTime(c.presaleEnd + 10)

    // Random investor tries to pay <$10k and expects _wei.mul(ethRate).div(16000000) tokens
    await meta.purchaseWithBTC(alsoNotOwner, value/1000, wei/1000, {from:admin})
    var actualTokens = await meta.balanceOf(alsoNotOwner)
    var calculatedTokens = web3.toBigNumber(wei/1000).mul(rate).div(16000000)

    actualTokens = actualTokens.toFixed(0)
    calculatedTokens = calculatedTokens.toFixed(0)

    ok = actualTokens == calculatedTokens
    assert(ok, `expected: ${calculatedTokens} got: ${actualTokens}`)
  })
})