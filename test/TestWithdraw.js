var Casper = artifacts.require('CasperToken')
var c = require('./lib/common.js')

contract('CasperToken', function (accounts) {
  const rate = 10 ** 14 // 1 ETH == 10^6 $

  const owner = accounts[0]
  const admin = accounts[1]
  const notOwner = accounts[2]
  const bank = accounts[3]

  const multisig = '0x741A26104530998F625D15cbb9D58b01811d2CA7'

  it('should transfer 75% of eth to the owner when withdrawFunds is called', async function () {
    const meta = await Casper.deployed()

    // Presale starts
    c.setTime(c.presaleStart + 10)

    // Admin sets ETHrate
    await meta.setAdmin(admin)
    await meta.setETHRate(rate, {from:admin})

    // Owner assigns team and preico tokens
    await meta.assignPreicoTokens()
    await meta.assignTeamTokens()

    // Random investor passes KYC
    await meta.kycPassed(notOwner, notOwner, {from:admin})

    var value = web3.toWei(10, 'ether')

    // Random investor pays 10 ether ($10M), so softcap is reached
    await meta.purchaseWithETH(notOwner, {from:notOwner, value:value})

    // Owner transfers bonus ($4.8M)
    await meta.transferBonus(bank, 4800000)

    // Crowdsale ends
    c.setTime(c.teamETHunlock1 + 10)

    // Owner closes ico
    await meta.closeICO()

    var finalBalance = web3.eth.getBalance(meta.address)

    // Owner tries to withdraw funds and expects to get 75% of eth
    var resp = await meta.withdrawFunds()

    var transferred = web3.eth.getBalance(multisig)
    var expected = finalBalance.mul(85).div(100)

    var ok = transferred.eq(expected)
    assert(ok, `expected: ${expected} transferred: ${transferred}`)
  })

  it('should properly transfer 15% of eth to team', async function() {
    const meta = await Casper.deployed()

    // 15% left
    var currentBalance = web3.eth.getBalance(meta.address)

    // 3 unlocks in total
    const ethPerUnlock = currentBalance.div(3)

    var ok

    await meta.withdrawTeam()
    var expectedBalance = currentBalance.sub(ethPerUnlock)
    currentBalance = web3.eth.getBalance(meta.address)
    ok = currentBalance.eq(expectedBalance)
    assert(ok, `expected: ${expectedBalance} got: ${currentBalance} after 1st team unlock`)

    // Second unlock
    c.setTime(c.teamETHunlock2 + 10)

    await meta.withdrawTeam()
    expectedBalance = currentBalance.sub(ethPerUnlock)
    currentBalance = web3.eth.getBalance(meta.address)
    ok = currentBalance.eq(expectedBalance)
    assert(ok, `expected: ${expectedBalance} got: ${currentBalance} after 2nd team unlock`)

    // Third unlock
    c.setTime(c.teamETHunlock3 + 10)

    await meta.withdrawTeam()
    expectedBalance = web3.toBigNumber(0)
    currentBalance = web3.eth.getBalance(meta.address)
    ok = currentBalance.eq(expectedBalance)
    assert(ok, `expected: ${expectedBalance} got: ${currentBalance} after 3rd team unlock`)
  })
})