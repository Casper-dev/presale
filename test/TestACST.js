var SC = artifacts.require('AdviserCasperToken')

contract('AdviserCasperToken', function (accounts) {
  // var owner = accounts[0]
  var tokens = 1000000
  var meta

  it('owner can use transfer', function () {
    var client = accounts[1]

    return SC.new().then(function (instance) {
      meta = instance
      return meta.transfer(client, tokens)
    })
      .then(function () { return meta.balanceOf(client) })
      .then(function (b) {
        assert.equal(b, tokens, 'client must have correct balance')
      })
  })

  it('anybody except owner cannot use transfer', function () {
    var pseudo = accounts[2]
    var client = accounts[3]

    return SC.new().then(function (instance) {
      meta = instance
      return meta.transfer(client, tokens, {from: pseudo})
    })
      .then(
        function (r) { assert(false, 'should have failed') },
        function (e) { }
      )
  })
})
