module.exports = {
  setTime (time) {
    var ts = web3.eth.getBlock(web3.eth.blockNumber).timestamp
    return web3.currentProvider.send({
      jsonrpc: '2.0',
      method: 'evm_increaseTime',
      params: [time - ts],
      id: 0
    })
  },

  gasCostWei (tx) {
    gasUsed = web3.eth.getTransactionReceipt(tx).cumulativeGasUsed
    gasPrice = web3.eth.getTransaction(tx).gasPrice
    return gasUsed * gasPrice
  },
  
  async error (promise) {
    return promise.then(data => false, err  => true)
  },

  async success (promise) {
    return promise.then(data => data, err  => false)
  },

  presaleStart: Date.parse('10 Jun 2018 00:00:00 GMT') / 1000,
  presaleEnd:   Date.parse('22 Jul 2018 23:59:59 GMT') / 1000,
  crowdEnd:     Date.parse('02 Aug 2018 23:59:59 GMT') / 1000,
  crowdHard:    Date.parse('16 Aug 2018 23:59:59 GMT') / 1000,
  unlock1:      Date.parse('28 Sep 2018 23:59:59 GMT') / 1000,
  unlock2:      Date.parse('30 Nov 2018 23:59:59 GMT') / 1000,
  unlock3:      Date.parse('31 Jan 2019 23:59:59 GMT') / 1000,
  unlock4:      Date.parse('29 Mar 2019 23:59:59 GMT') / 1000,
  unlock5:      Date.parse('31 May 2019 23:59:59 GMT') / 1000
}
