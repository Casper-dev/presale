# Casper Token Audit

```
June 2018
By Coinfabrik
```
http://blog.coinfabrik.com/casper-cst-token-sale-security-audit/

- Introduction
- Summary
- Detailed findings
   - Minor severity
      - Possible overflow in purchase functions
   - Enhancements
      - Consistent use of SafeMath
      - Use of modern solidity compiler pragmas
- Conclusion
- References


## Introduction

```
Coinfabrik was asked to audit the contracts for the Casper Token sale. ​Firstly, we will
provide a summary of our discoveries and secondly, we will show​ the details of our findings.
```
## Summary

The contracts audited are from the _presale_ repository at https://github.com/Casper-dev/presale. The audit is based on the commit https://github.com/Casper-dev/presale/tree/3c66514423277c39bea26e62a7de47d51d712108 from branch _feat/presale_. This audit was updated to reflect the changes done on commit https://github.com/Casper-dev/presale/tree/8a702734c70e335661d21d04b9c995748d7b27b8 on the same branch.

The audited contracts are:
- contracts/AdviserCasperToken.sol: An adviser token which can be converted directly to CST
- contracts/CasperToken.sol: The token itself

The Casper token sale will have two phases: a presale one where each token will be sold at
a fixed rate of $0.12 USD per token, and a sale one where they will be sold at $0.16 USD.
There also is an adviser token sale contract which will be able to be exchanged 1:1 with the
main token.
The following analyses were performed:
- Misuse of the different call methods: call.value(), send() and transfer().
- Integer rounding errors, overflow, underflow and related usage of SafeMath
functions.
- Old compiler version pragmas.
- Race conditions such as reentrancy attacks or front running.
- Misuse of block timestamps, assuming anything other than them being strictly
increasing.
- Contract softlocking attacks (DoS).
- Potential gas cost of functions being over the gas limit.
- Missing function qualifiers and their misuse.
- Fallback functions with a higher gas cost than the one that a transfer or send call
allows.
- Fraudulent or erroneous code.
- Code and contract interaction complexity.
- Wrong or missing error handling.
- Overuse of transfers in a single transaction instead of using withdrawal patterns.
- Insufficient analysis of the function input requirements.


## Detailed findings

### Minor severity

#### Possible overflow in purchase functions

In CasperToken.sol, there are lines in the purchase functions where a value is set with an
addition, but these are unprotected against overflow. One of those is only callable by the
 contract owner, while the other one is public, in the functions _purchaseWithBTC_ and
 _purchaseWithPromoter_. The lines which could be rewritten are the following:
```solidity
function purchaseWithPromoter(address _to, address _ref) payable public {
    require(now >= presaleStartTime && now <= crowdsaleEndTime);
    uint _wei = msg.value;
    uint cst;
    ethSent[msg.sender] += _wei;
    ethSold += _wei;
//...
}
```
And:
```solidity
​function​ purchaseWithBTC​(​address _to​,​ ​uint​ _satoshi​,​ ​uint​ _wei​)​ ​public​ {
    require​(​msg​.​sender ​==​ admin ​||​ msg​.​sender ​==​ director ​||​ msg​.​sender ​==​ owner​);
    require​(​now ​>=​ presaleStartTime ​&&​ now ​<=​ crowdsaleEndTime​);
    ethSold += _wei;
    uint​ cst;
// ...
}
```
While the above was fixed in the latest commits, we've found the same possibility in the
withdrawTeam function, in the latest commit., in the following:
```solidity
function​ withdrawTeam​()​ ​public​ {
    require​(​now ​>=​ teamETHUnlock1​);
    uint​ amount ​=​ ​0;
    if​ ​(​now ​<​ teamETHUnlock2​)​ {
        amount = teamETH1;
        teamETH1 ​=​ ​0;
    }​ ​else​ ​if​ ​(​now ​<​ teamETHUnlock3​)​ {
        amount = teamETH1​ + teamETH2;
        teamETH1 ​=​ ​0;
        teamETH2 ​=​ ​0;
    }​ ​else​ {
        amount = teamETH1​ + teamETH2 + teamETH3;
        teamETH1 ​=​ ​0;
        teamETH2 ​=​ ​0;
        teamETH3 ​=​ ​0;
    }
    //...
```

### Enhancements

#### Consistent use of SafeMath

In some parts of the code we’ve found lack of usage of SafeMath. We advice the use of the
aforementioned code library in lines like:
```solidity
cst ​=​ _satoshi​.​mul​(​btcRate​.​mul​(​ 10000 ​))​ ​/​ ​12;
```

By forcing the use of such a code library the code is guaranteed to avoid situations like
overflow.

#### Use of modern solidity compiler pragmas

The contracts provided use the following compiler pragmas:
```solidity
pragma solidity ​^​0.4​.​19;
```

We strongly suggest updating the compiler version, so as to avoid any possible legibility
issues, since newer compiler versions include features such as distinguishing the
constructor and event emission with keywords, which means the legibility of the contract is
improved against possible future developments.
_This observation was fixed in the last commit sent to us._

#### Use of modifiers for common require clauses

The contract uses require clauses mixed in the function code. In general, the contract’s
legibility could be improved by putting frequently used clauses in modifiers, by typing:
```solidity
modifier onlyOwnerAndAdmin​()​ {
    ​require​(​msg​.​sender ​==​ owner ​||​ msg​.​sender ​==​ admin​);
    _;
}
modifier onlyOwnerAndDirector​(){
    ​require​(​msg​.​sender ​==​ owner ​||​ msg​.​sender ​==​ director​);
    _;
}
```

_This was fixed in the last commit sent to us, save for the redundant use in setMaxRate._

## Conclusion

We found the contracts to be simple and straightforward and have an adequate amount of
documentation. Some minor issues were found, but it is unlikely they could cause critical
security problems. After contacting the development team, they were fixed in the next
commits.


