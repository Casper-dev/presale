var Casper = artifacts.require('CasperToken')
var c = require('./lib/common.js')

contract('CasperToken', function (accounts) {
  const rate = 10 ** 14 // 1 ETH == 10^6 $

  const admin = accounts[1]
  const notOwner = accounts[2]
  const kindBoy = accounts[3]

  const igorKoval = '0x041A1e96E0C9d3957613071c104E44a9c9d43996'

  it('should assign team tokens correctly', async function() {
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

    // Crowdsale ends
    c.setTime(c.crowdEnd + 10)

    // Owner closes ico
    await meta.closeICO()

    // Igor worked hard so he expects to receive 150k tokens
    var igorBalance = await meta.balanceOf(igorKoval)
    var expected = web3.toBigNumber(150000).mul(10 ** 18)
    var ok = igorBalance.eq(expected)
    assert(ok, `Igor expected: ${expected} but got: ${igorBalance}`)
  })

  it('should not allow team to transfer tokens before unlocks', async function () {
    const meta = await Casper.deployed()

    // Igor finds some debels that gave him eth and now he can make transfers
    web3.eth.sendTransaction({from:kindBoy, to:igorKoval, value: web3.toWei(10, 'ether')})

    // Igor wants to transfer his tokens immediately but he cant
    var value = web3.toBigNumber(37500).mul(10 ** 18)
    var ok = await c.error(meta.transfer(kindBoy, value, {from:igorKoval}))
    assert(ok, 'Igor managed to transfer his tokens before 1st unlock')

    // So Igor waits until first team unlock
    c.setTime(c.teamUnlock1 + 10)

    // And makes a new try
    await meta.transfer(kindBoy, value, {from:igorKoval})

    // His tokens had been successfully transfered to other wallet, so he decided to try again
    ok = await c.error(meta.transfer(kindBoy, value, {from:igorKoval}))
    assert(ok, 'Igor managed to transfer >25% of his tokens after 1st unlock')

    c.setTime(c.teamUnlock2 + 10)

    // Now Igor realized that he have to wait until all unlocks reached but he does not give up trying his luck
    await meta.transfer(kindBoy, value, {from:igorKoval})
    ok = await c.error(meta.transfer(kindBoy, value, {from:igorKoval}))
    assert(ok, 'Igor managed to transfer >50% of his tokens after 2nd unlock')

    c.setTime(c.teamUnlock3 + 10)

    await meta.transfer(kindBoy, value, {from:igorKoval})
    ok = await c.error(meta.transfer(kindBoy, value, {from:igorKoval}))
    assert(ok, 'Igor managed to transfer >75% of his tokens after 3rd unlock')

    c.setTime(c.teamUnlock4 + 10)

    // Last tokens
    await meta.transfer(kindBoy, value, {from:igorKoval})
  })
})