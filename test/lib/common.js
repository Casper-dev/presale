// Create EVM state snapshot and return its id
function snapshot() {
  return parseInt(web3.currentProvider.send({
    jsonrpc: "2.0",
    method: "evm_snapshot",
    id: new Date().getTime()
  }).result)
}

// Revert EVM state to a certain snapshot
function revert(id) {
  var resp = web3.currentProvider.send({
    jsonrpc: "2.0",
    method: "evm_revert",
    params: [id || module.exports.initSnapshot],
    id: new Date().getTime()
  })

  // Revert pops all snapshots that has higher id than target.
  // So after reverting we need to create a new snapshot.
  // https://github.com/trufflesuite/ganache-core/blob/e2c1a0f5913cc31cb1022eb86e8306d7384b1602/lib/statemanager.js#L730
  module.exports.initSnapshot = snapshot()

  return resp
}

// Travel through time
function setTime(time) {
  var ts = web3.eth.getBlock(web3.eth.blockNumber).timestamp
  return web3.currentProvider.send({
    jsonrpc: '2.0',
    method: 'evm_increaseTime',
    params: [time - ts],
    id: new Date().getTime()
  })
}

// Calculate tx gas cost in wei
function gasCostWei(tx) {
  gasUsed = web3.eth.getTransactionReceipt(tx).cumulativeGasUsed
  gasPrice = web3.eth.getTransaction(tx).gasPrice
  return gasUsed * gasPrice
}

// Return true if promise is rejected else false
async function error (promise) {
  return promise.then(data => false, err  => true)
}

// Return data if promise is resolved else false
async function success (promise) {
  return promise.then(data => data, err  => false)
}

module.exports = {
  // Values
  initSnapshot: snapshot(),
  presaleStart: Date.parse('10 Jun 2018 00:00:00 GMT') / 1000,
  presaleEnd:   Date.parse('22 Jul 2018 23:59:59 GMT') / 1000,
  crowdEnd:     Date.parse('02 Aug 2018 23:59:59 GMT') / 1000,
  crowdHard:    Date.parse('16 Aug 2018 23:59:59 GMT') / 1000,
  unlock1:      Date.parse('28 Sep 2018 23:59:59 GMT') / 1000,
  unlock2:      Date.parse('30 Nov 2018 23:59:59 GMT') / 1000,
  unlock3:      Date.parse('31 Jan 2019 23:59:59 GMT') / 1000,
  unlock4:      Date.parse('29 Mar 2019 23:59:59 GMT') / 1000,
  unlock5:      Date.parse('31 May 2019 23:59:59 GMT') / 1000,

  // Functions
  snapshot,
  revert,
  setTime,
  gasCostWei,
  error,
  success
}
