var Casper = artifacts.require('CasperToken')
var c = require('./lib/common.js')

contract('CasperToken', function (accounts) {
  const rate = 10 ** 12 // 1 ETH == 10^4 $

  // Roles
  const owner = accounts[0]
  const admin = accounts[1]
  const notOwner = accounts[2]
  const alsoNotOwner = accounts[3]
  const approvedBoy = accounts[4]

  const value = web3.toWei(12, 'ether')

  it('should revert purchase <$10k during presale', async function () {
    const meta = await Casper.deployed()

    await meta.approveInvestor(approvedBoy, {from:owner})

    // Presale starts
    c.setTime(c.presaleStart + 10)

    // Admin sets ETHrate
    await meta.setAdmin(admin)
    await meta.setETHRate(rate, {from:admin})

    // Owner assigns team and preico tokens
    await meta.assignPreicoTokens()
    await meta.assignTeamTokens()

    // Random investors pass KYC
    await meta.kycPassed(notOwner, notOwner, {from:admin})
    await meta.kycPassed(alsoNotOwner, alsoNotOwner, {from:admin})
    await meta.kycPassed(approvedBoy, approvedBoy, {from:admin})

    // Random investor tries to pay <9950 usd
    var ok = await c.error(meta.purchaseWithETH(notOwner, {from:notOwner, value:value/1000}))
    assert(ok, 'purchase was not reverted')
  })

  it('should pass purchase >$10k at a presale price', async function() {
    const meta = await Casper.deployed()

    // Random investor tries to pay 10 ether and expects _wei.mul(ethRate).div(12000000) tokens
    await meta.purchaseWithETH(notOwner, {from:notOwner, value:value})
    var actualTokens = await meta.balanceOf(notOwner)
    var calculatedTokens = web3.toBigNumber(value).mul(rate).div(12000000)

    // Actual and calculated tokens are of different precision
    // so we cant compare them directly
    // http://mikemcl.github.io/bignumber.js/#toFix
    // http://mikemcl.github.io/bignumber.js/#sd
    actualTokens = actualTokens.toFixed(0)
    calculatedTokens = calculatedTokens.toFixed(0)

    var ok = actualTokens == calculatedTokens
    assert(ok, `expected: ${calculatedTokens} got: ${actualTokens}`)
  })
  
  it('should pass purchase >$10 at a crowdsale price when crowdsale starts', async function() {
    const meta = await Casper.deployed()

    // Crowdsale starts
    c.setTime(c.presaleEnd + 10)

    // Random investor tries to pay and expects _wei.mul(ethRate).div(16000000) tokens
    await meta.purchaseWithETH(alsoNotOwner, {from:alsoNotOwner, value:value})
    var actualTokens = await meta.balanceOf(alsoNotOwner)
    var calculatedTokens = web3.toBigNumber(value).mul(rate).div(16000000)

    actualTokens = actualTokens.toFixed(0)
    calculatedTokens = calculatedTokens.toFixed(0)

    ok = actualTokens == calculatedTokens

    assert(ok, `expected: ${calculatedTokens} got: ${actualTokens}`)
  })

  it('should always pass purchase >$100k at a presale price', async function() {
    const meta = await Casper.deployed()

    // Approved investor tries to pay 12 ether (>$100k) and expects _wei.mul(ethRate).div(12000000) tokens
    await meta.purchaseWithETH(approvedBoy, {from:approvedBoy, value:value})
    var actualTokens = await meta.balanceOf(approvedBoy)
    var calculatedTokens = web3.toBigNumber(value).mul(rate).div(12000000)

    actualTokens = actualTokens.toFixed(0)
    calculatedTokens = calculatedTokens.toFixed(0)

    ok = actualTokens == calculatedTokens
    assert(ok, `expected: ${calculatedTokens} got: ${actualTokens}`)
  })
})