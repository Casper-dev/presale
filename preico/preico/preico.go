// Code generated - DO NOT EDIT.
// This file is a generated binding and any manual changes will be lost.

package preico

import (
	"math/big"
	"strings"

	"github.com/ethereum/go-ethereum/accounts/abi"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
)

// CasperABI is the input ABI used to generate the binding from.
const CasperABI = "[{\"constant\":true,\"inputs\":[],\"name\":\"MAX_PRICE\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"setTrusted\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"TOKEN_SUPPLY_LIMIT\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"index\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"DECIMALS\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"endTime\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"eth\",\"type\":\"uint256\"}],\"name\":\"withdrawEther\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[],\"name\":\"sendPresaleTokens\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"trusted\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"beginTime\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"newPrice\",\"type\":\"uint256\"}],\"name\":\"setPrice\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"price\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"NAME\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"MIN_PRICE\",\"outputs\":[{\"name\":\"\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"setNewOwner\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"SYMBOL\",\"outputs\":[{\"name\":\"\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"payable\":true,\"stateMutability\":\"payable\",\"type\":\"fallback\"}]"

// CasperBin is the compiled bytecode used for deploying new contracts.
const CasperBin = `0x6080604052600060028190556104106005556006819055600955600a805460ff1916600117905534801561003257600080fd5b5060008054600160a060020a03191633600160a060020a031617905561007f7341c8f018d10f500d231f723017389da5ff9f45f269040ecd1bdeb946da0000640100000000610092810204565b42600781905562127500016008556100d9565b6002805460009081526003602090815260408083208054600160a060020a03909716600160a060020a03199097168717905594825260049052929092205580546001019055565b6107f4806100e86000396000f3006080604052600436106101065763ffffffff7c010000000000000000000000000000000000000000000000000000000060003504166301c11d96811461021557806318160ddd1461023c5780631924066114610251578063292005a2146102745780632986c0e5146102895780632e0f26251461029e5780633197cbb6146102b35780633bed33ce146102c8578063400a4deb146102e057806370a08231146102f55780637e2a6db81461031657806388149fb9146103475780638da5cb5b1461035c57806391b7f5ed14610371578063a035b1fe14610389578063a3f4df7e1461039e578063ad9f20a614610428578063f5a1f5b41461043d578063f76f8d781461045e575b6000806008544210151561011957600080fd5b6006546a011349242670ce848000001161013257600080fd5b600554340291506a011349242670ce8480000060065483011115156101a257600160a060020a0333166000908152600b60205260409020546101749083610473565b600160a060020a0333166000908152600b602052604090205560065461019a9083610473565b600655610208565b6101b96a011349242670ce84800000600654610497565b600160a060020a0333166000908152600b60205260409020549091506101df9082610473565b600160a060020a0333166000908152600b60205260409020556a011349242670ce848000006006555b610211336104ab565b5050005b34801561022157600080fd5b5061022a6104f2565b60408051918252519081900360200190f35b34801561024857600080fd5b5061022a6104f8565b34801561025d57600080fd5b50610272600160a060020a03600435166104fe565b005b34801561028057600080fd5b5061022a610548565b34801561029557600080fd5b5061022a610557565b3480156102aa57600080fd5b5061022a61055d565b3480156102bf57600080fd5b5061022a610562565b3480156102d457600080fd5b50610272600435610568565b3480156102ec57600080fd5b506102726105c0565b34801561030157600080fd5b5061022a600160a060020a036004351661066d565b34801561032257600080fd5b5061032b610688565b60408051600160a060020a039092168252519081900360200190f35b34801561035357600080fd5b5061022a610697565b34801561036857600080fd5b5061032b61069d565b34801561037d57600080fd5b506102726004356106ac565b34801561039557600080fd5b5061022a610704565b3480156103aa57600080fd5b506103b361070a565b6040805160208082528351818301528351919283929083019185019080838360005b838110156103ed5781810151838201526020016103d5565b50505050905090810190601f16801561041a5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b34801561043457600080fd5b5061022a610741565b34801561044957600080fd5b50610272600160a060020a0360043516610747565b34801561046a57600080fd5b506103b3610791565b60008282018381108015906104885750828110155b151561049057fe5b9392505050565b600080828410156104a457fe5b5050900390565b600980546000908152600c60205260409020805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a03939093169290921790915580546001019055565b6104e281565b60065481565b60005433600160a060020a0390811691161461051957600080fd5b6001805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0392909216919091179055565b6a011349242670ce8480000081565b60095481565b601281565b60085481565b60005433600160a060020a0390811691161461058357600080fd5b60008054604051600160a060020a039091169183156108fc02918491818181858888f193505050501580156105bc573d6000803e3d6000fd5b5050565b600080548190819033600160a060020a039081169116146105e057600080fd5b600a5460ff1615156105f157600080fd5b600092505b60025483101561064d575050600081815260036020908152604080832054600160a060020a03168084526004835281842054600b909352922081905560065461063f9082610473565b6006556001909201916105f6565b61065b600954600254610473565b6009555050600a805460ff1916905550565b600160a060020a03166000908152600b602052604090205490565b600154600160a060020a031681565b60075481565b600054600160a060020a031681565b60015433600160a060020a03908116911614806106d7575060005433600160a060020a039081169116145b15156106e257600080fd5b6102ee811180156106f457506104e281105b15156106ff57600080fd5b600555565b60055481565b60408051808201909152601481527f436173706572205072652d49434f20546f6b656e000000000000000000000000602082015281565b6102ee81565b60005433600160a060020a0390811691161461076257600080fd5b6000805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0392909216919091179055565b60408051808201909152600481527f43535054000000000000000000000000000000000000000000000000000000006020820152815600a165627a7a72305820ec344ef47eec521f8d5085b04d36c118c4af34c81bf3151d6637f874dd6434760029`

// DeployCasper deploys a new Ethereum contract, binding an instance of Casper to it.
func DeployCasper(auth *bind.TransactOpts, backend bind.ContractBackend) (common.Address, *types.Transaction, *Casper, error) {
	parsed, err := abi.JSON(strings.NewReader(CasperABI))
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	address, tx, contract, err := bind.DeployContract(auth, parsed, common.FromHex(CasperBin), backend)
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	return address, tx, &Casper{CasperCaller: CasperCaller{contract: contract}, CasperTransactor: CasperTransactor{contract: contract}, CasperFilterer: CasperFilterer{contract: contract}}, nil
}

// Casper is an auto generated Go binding around an Ethereum contract.
type Casper struct {
	CasperCaller     // Read-only binding to the contract
	CasperTransactor // Write-only binding to the contract
	CasperFilterer   // Log filterer for contract events
}

// CasperCaller is an auto generated read-only Go binding around an Ethereum contract.
type CasperCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// CasperTransactor is an auto generated write-only Go binding around an Ethereum contract.
type CasperTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// CasperFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type CasperFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// CasperSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type CasperSession struct {
	Contract     *Casper           // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// CasperCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type CasperCallerSession struct {
	Contract *CasperCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts // Call options to use throughout this session
}

// CasperTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type CasperTransactorSession struct {
	Contract     *CasperTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// CasperRaw is an auto generated low-level Go binding around an Ethereum contract.
type CasperRaw struct {
	Contract *Casper // Generic contract binding to access the raw methods on
}

// CasperCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type CasperCallerRaw struct {
	Contract *CasperCaller // Generic read-only contract binding to access the raw methods on
}

// CasperTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type CasperTransactorRaw struct {
	Contract *CasperTransactor // Generic write-only contract binding to access the raw methods on
}

// NewCasper creates a new instance of Casper, bound to a specific deployed contract.
func NewCasper(address common.Address, backend bind.ContractBackend) (*Casper, error) {
	contract, err := bindCasper(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &Casper{CasperCaller: CasperCaller{contract: contract}, CasperTransactor: CasperTransactor{contract: contract}, CasperFilterer: CasperFilterer{contract: contract}}, nil
}

// NewCasperCaller creates a new read-only instance of Casper, bound to a specific deployed contract.
func NewCasperCaller(address common.Address, caller bind.ContractCaller) (*CasperCaller, error) {
	contract, err := bindCasper(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &CasperCaller{contract: contract}, nil
}

// NewCasperTransactor creates a new write-only instance of Casper, bound to a specific deployed contract.
func NewCasperTransactor(address common.Address, transactor bind.ContractTransactor) (*CasperTransactor, error) {
	contract, err := bindCasper(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &CasperTransactor{contract: contract}, nil
}

// NewCasperFilterer creates a new log filterer instance of Casper, bound to a specific deployed contract.
func NewCasperFilterer(address common.Address, filterer bind.ContractFilterer) (*CasperFilterer, error) {
	contract, err := bindCasper(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &CasperFilterer{contract: contract}, nil
}

// bindCasper binds a generic wrapper to an already deployed contract.
func bindCasper(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := abi.JSON(strings.NewReader(CasperABI))
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Casper *CasperRaw) Call(opts *bind.CallOpts, result interface{}, method string, params ...interface{}) error {
	return _Casper.Contract.CasperCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Casper *CasperRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Casper.Contract.CasperTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Casper *CasperRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Casper.Contract.CasperTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Casper *CasperCallerRaw) Call(opts *bind.CallOpts, result interface{}, method string, params ...interface{}) error {
	return _Casper.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Casper *CasperTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Casper.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Casper *CasperTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Casper.Contract.contract.Transact(opts, method, params...)
}

// DECIMALS is a free data retrieval call binding the contract method 0x2e0f2625.
//
// Solidity: function DECIMALS() constant returns(uint256)
func (_Casper *CasperCaller) DECIMALS(opts *bind.CallOpts) (*big.Int, error) {
	var (
		ret0 = new(*big.Int)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "DECIMALS")
	return *ret0, err
}

// DECIMALS is a free data retrieval call binding the contract method 0x2e0f2625.
//
// Solidity: function DECIMALS() constant returns(uint256)
func (_Casper *CasperSession) DECIMALS() (*big.Int, error) {
	return _Casper.Contract.DECIMALS(&_Casper.CallOpts)
}

// DECIMALS is a free data retrieval call binding the contract method 0x2e0f2625.
//
// Solidity: function DECIMALS() constant returns(uint256)
func (_Casper *CasperCallerSession) DECIMALS() (*big.Int, error) {
	return _Casper.Contract.DECIMALS(&_Casper.CallOpts)
}

// MAXPRICE is a free data retrieval call binding the contract method 0x01c11d96.
//
// Solidity: function MAX_PRICE() constant returns(uint256)
func (_Casper *CasperCaller) MAXPRICE(opts *bind.CallOpts) (*big.Int, error) {
	var (
		ret0 = new(*big.Int)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "MAX_PRICE")
	return *ret0, err
}

// MAXPRICE is a free data retrieval call binding the contract method 0x01c11d96.
//
// Solidity: function MAX_PRICE() constant returns(uint256)
func (_Casper *CasperSession) MAXPRICE() (*big.Int, error) {
	return _Casper.Contract.MAXPRICE(&_Casper.CallOpts)
}

// MAXPRICE is a free data retrieval call binding the contract method 0x01c11d96.
//
// Solidity: function MAX_PRICE() constant returns(uint256)
func (_Casper *CasperCallerSession) MAXPRICE() (*big.Int, error) {
	return _Casper.Contract.MAXPRICE(&_Casper.CallOpts)
}

// MINPRICE is a free data retrieval call binding the contract method 0xad9f20a6.
//
// Solidity: function MIN_PRICE() constant returns(uint256)
func (_Casper *CasperCaller) MINPRICE(opts *bind.CallOpts) (*big.Int, error) {
	var (
		ret0 = new(*big.Int)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "MIN_PRICE")
	return *ret0, err
}

// MINPRICE is a free data retrieval call binding the contract method 0xad9f20a6.
//
// Solidity: function MIN_PRICE() constant returns(uint256)
func (_Casper *CasperSession) MINPRICE() (*big.Int, error) {
	return _Casper.Contract.MINPRICE(&_Casper.CallOpts)
}

// MINPRICE is a free data retrieval call binding the contract method 0xad9f20a6.
//
// Solidity: function MIN_PRICE() constant returns(uint256)
func (_Casper *CasperCallerSession) MINPRICE() (*big.Int, error) {
	return _Casper.Contract.MINPRICE(&_Casper.CallOpts)
}

// NAME is a free data retrieval call binding the contract method 0xa3f4df7e.
//
// Solidity: function NAME() constant returns(string)
func (_Casper *CasperCaller) NAME(opts *bind.CallOpts) (string, error) {
	var (
		ret0 = new(string)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "NAME")
	return *ret0, err
}

// NAME is a free data retrieval call binding the contract method 0xa3f4df7e.
//
// Solidity: function NAME() constant returns(string)
func (_Casper *CasperSession) NAME() (string, error) {
	return _Casper.Contract.NAME(&_Casper.CallOpts)
}

// NAME is a free data retrieval call binding the contract method 0xa3f4df7e.
//
// Solidity: function NAME() constant returns(string)
func (_Casper *CasperCallerSession) NAME() (string, error) {
	return _Casper.Contract.NAME(&_Casper.CallOpts)
}

// SYMBOL is a free data retrieval call binding the contract method 0xf76f8d78.
//
// Solidity: function SYMBOL() constant returns(string)
func (_Casper *CasperCaller) SYMBOL(opts *bind.CallOpts) (string, error) {
	var (
		ret0 = new(string)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "SYMBOL")
	return *ret0, err
}

// SYMBOL is a free data retrieval call binding the contract method 0xf76f8d78.
//
// Solidity: function SYMBOL() constant returns(string)
func (_Casper *CasperSession) SYMBOL() (string, error) {
	return _Casper.Contract.SYMBOL(&_Casper.CallOpts)
}

// SYMBOL is a free data retrieval call binding the contract method 0xf76f8d78.
//
// Solidity: function SYMBOL() constant returns(string)
func (_Casper *CasperCallerSession) SYMBOL() (string, error) {
	return _Casper.Contract.SYMBOL(&_Casper.CallOpts)
}

// TOKENSUPPLYLIMIT is a free data retrieval call binding the contract method 0x292005a2.
//
// Solidity: function TOKEN_SUPPLY_LIMIT() constant returns(uint256)
func (_Casper *CasperCaller) TOKENSUPPLYLIMIT(opts *bind.CallOpts) (*big.Int, error) {
	var (
		ret0 = new(*big.Int)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "TOKEN_SUPPLY_LIMIT")
	return *ret0, err
}

// TOKENSUPPLYLIMIT is a free data retrieval call binding the contract method 0x292005a2.
//
// Solidity: function TOKEN_SUPPLY_LIMIT() constant returns(uint256)
func (_Casper *CasperSession) TOKENSUPPLYLIMIT() (*big.Int, error) {
	return _Casper.Contract.TOKENSUPPLYLIMIT(&_Casper.CallOpts)
}

// TOKENSUPPLYLIMIT is a free data retrieval call binding the contract method 0x292005a2.
//
// Solidity: function TOKEN_SUPPLY_LIMIT() constant returns(uint256)
func (_Casper *CasperCallerSession) TOKENSUPPLYLIMIT() (*big.Int, error) {
	return _Casper.Contract.TOKENSUPPLYLIMIT(&_Casper.CallOpts)
}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(addr address) constant returns(uint256)
func (_Casper *CasperCaller) BalanceOf(opts *bind.CallOpts, addr common.Address) (*big.Int, error) {
	var (
		ret0 = new(*big.Int)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "balanceOf", addr)
	return *ret0, err
}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(addr address) constant returns(uint256)
func (_Casper *CasperSession) BalanceOf(addr common.Address) (*big.Int, error) {
	return _Casper.Contract.BalanceOf(&_Casper.CallOpts, addr)
}

// BalanceOf is a free data retrieval call binding the contract method 0x70a08231.
//
// Solidity: function balanceOf(addr address) constant returns(uint256)
func (_Casper *CasperCallerSession) BalanceOf(addr common.Address) (*big.Int, error) {
	return _Casper.Contract.BalanceOf(&_Casper.CallOpts, addr)
}

// BeginTime is a free data retrieval call binding the contract method 0x88149fb9.
//
// Solidity: function beginTime() constant returns(uint256)
func (_Casper *CasperCaller) BeginTime(opts *bind.CallOpts) (*big.Int, error) {
	var (
		ret0 = new(*big.Int)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "beginTime")
	return *ret0, err
}

// BeginTime is a free data retrieval call binding the contract method 0x88149fb9.
//
// Solidity: function beginTime() constant returns(uint256)
func (_Casper *CasperSession) BeginTime() (*big.Int, error) {
	return _Casper.Contract.BeginTime(&_Casper.CallOpts)
}

// BeginTime is a free data retrieval call binding the contract method 0x88149fb9.
//
// Solidity: function beginTime() constant returns(uint256)
func (_Casper *CasperCallerSession) BeginTime() (*big.Int, error) {
	return _Casper.Contract.BeginTime(&_Casper.CallOpts)
}

// EndTime is a free data retrieval call binding the contract method 0x3197cbb6.
//
// Solidity: function endTime() constant returns(uint256)
func (_Casper *CasperCaller) EndTime(opts *bind.CallOpts) (*big.Int, error) {
	var (
		ret0 = new(*big.Int)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "endTime")
	return *ret0, err
}

// EndTime is a free data retrieval call binding the contract method 0x3197cbb6.
//
// Solidity: function endTime() constant returns(uint256)
func (_Casper *CasperSession) EndTime() (*big.Int, error) {
	return _Casper.Contract.EndTime(&_Casper.CallOpts)
}

// EndTime is a free data retrieval call binding the contract method 0x3197cbb6.
//
// Solidity: function endTime() constant returns(uint256)
func (_Casper *CasperCallerSession) EndTime() (*big.Int, error) {
	return _Casper.Contract.EndTime(&_Casper.CallOpts)
}

// Index is a free data retrieval call binding the contract method 0x2986c0e5.
//
// Solidity: function index() constant returns(uint256)
func (_Casper *CasperCaller) Index(opts *bind.CallOpts) (*big.Int, error) {
	var (
		ret0 = new(*big.Int)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "index")
	return *ret0, err
}

// Index is a free data retrieval call binding the contract method 0x2986c0e5.
//
// Solidity: function index() constant returns(uint256)
func (_Casper *CasperSession) Index() (*big.Int, error) {
	return _Casper.Contract.Index(&_Casper.CallOpts)
}

// Index is a free data retrieval call binding the contract method 0x2986c0e5.
//
// Solidity: function index() constant returns(uint256)
func (_Casper *CasperCallerSession) Index() (*big.Int, error) {
	return _Casper.Contract.Index(&_Casper.CallOpts)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() constant returns(address)
func (_Casper *CasperCaller) Owner(opts *bind.CallOpts) (common.Address, error) {
	var (
		ret0 = new(common.Address)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "owner")
	return *ret0, err
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() constant returns(address)
func (_Casper *CasperSession) Owner() (common.Address, error) {
	return _Casper.Contract.Owner(&_Casper.CallOpts)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() constant returns(address)
func (_Casper *CasperCallerSession) Owner() (common.Address, error) {
	return _Casper.Contract.Owner(&_Casper.CallOpts)
}

// Price is a free data retrieval call binding the contract method 0xa035b1fe.
//
// Solidity: function price() constant returns(uint256)
func (_Casper *CasperCaller) Price(opts *bind.CallOpts) (*big.Int, error) {
	var (
		ret0 = new(*big.Int)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "price")
	return *ret0, err
}

// Price is a free data retrieval call binding the contract method 0xa035b1fe.
//
// Solidity: function price() constant returns(uint256)
func (_Casper *CasperSession) Price() (*big.Int, error) {
	return _Casper.Contract.Price(&_Casper.CallOpts)
}

// Price is a free data retrieval call binding the contract method 0xa035b1fe.
//
// Solidity: function price() constant returns(uint256)
func (_Casper *CasperCallerSession) Price() (*big.Int, error) {
	return _Casper.Contract.Price(&_Casper.CallOpts)
}

// TotalSupply is a free data retrieval call binding the contract method 0x18160ddd.
//
// Solidity: function totalSupply() constant returns(uint256)
func (_Casper *CasperCaller) TotalSupply(opts *bind.CallOpts) (*big.Int, error) {
	var (
		ret0 = new(*big.Int)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "totalSupply")
	return *ret0, err
}

// TotalSupply is a free data retrieval call binding the contract method 0x18160ddd.
//
// Solidity: function totalSupply() constant returns(uint256)
func (_Casper *CasperSession) TotalSupply() (*big.Int, error) {
	return _Casper.Contract.TotalSupply(&_Casper.CallOpts)
}

// TotalSupply is a free data retrieval call binding the contract method 0x18160ddd.
//
// Solidity: function totalSupply() constant returns(uint256)
func (_Casper *CasperCallerSession) TotalSupply() (*big.Int, error) {
	return _Casper.Contract.TotalSupply(&_Casper.CallOpts)
}

// Trusted is a free data retrieval call binding the contract method 0x7e2a6db8.
//
// Solidity: function trusted() constant returns(address)
func (_Casper *CasperCaller) Trusted(opts *bind.CallOpts) (common.Address, error) {
	var (
		ret0 = new(common.Address)
	)
	out := ret0
	err := _Casper.contract.Call(opts, out, "trusted")
	return *ret0, err
}

// Trusted is a free data retrieval call binding the contract method 0x7e2a6db8.
//
// Solidity: function trusted() constant returns(address)
func (_Casper *CasperSession) Trusted() (common.Address, error) {
	return _Casper.Contract.Trusted(&_Casper.CallOpts)
}

// Trusted is a free data retrieval call binding the contract method 0x7e2a6db8.
//
// Solidity: function trusted() constant returns(address)
func (_Casper *CasperCallerSession) Trusted() (common.Address, error) {
	return _Casper.Contract.Trusted(&_Casper.CallOpts)
}

// SendPresaleTokens is a paid mutator transaction binding the contract method 0x400a4deb.
//
// Solidity: function sendPresaleTokens() returns()
func (_Casper *CasperTransactor) SendPresaleTokens(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Casper.contract.Transact(opts, "sendPresaleTokens")
}

// SendPresaleTokens is a paid mutator transaction binding the contract method 0x400a4deb.
//
// Solidity: function sendPresaleTokens() returns()
func (_Casper *CasperSession) SendPresaleTokens() (*types.Transaction, error) {
	return _Casper.Contract.SendPresaleTokens(&_Casper.TransactOpts)
}

// SendPresaleTokens is a paid mutator transaction binding the contract method 0x400a4deb.
//
// Solidity: function sendPresaleTokens() returns()
func (_Casper *CasperTransactorSession) SendPresaleTokens() (*types.Transaction, error) {
	return _Casper.Contract.SendPresaleTokens(&_Casper.TransactOpts)
}

// SetNewOwner is a paid mutator transaction binding the contract method 0xf5a1f5b4.
//
// Solidity: function setNewOwner(newOwner address) returns()
func (_Casper *CasperTransactor) SetNewOwner(opts *bind.TransactOpts, newOwner common.Address) (*types.Transaction, error) {
	return _Casper.contract.Transact(opts, "setNewOwner", newOwner)
}

// SetNewOwner is a paid mutator transaction binding the contract method 0xf5a1f5b4.
//
// Solidity: function setNewOwner(newOwner address) returns()
func (_Casper *CasperSession) SetNewOwner(newOwner common.Address) (*types.Transaction, error) {
	return _Casper.Contract.SetNewOwner(&_Casper.TransactOpts, newOwner)
}

// SetNewOwner is a paid mutator transaction binding the contract method 0xf5a1f5b4.
//
// Solidity: function setNewOwner(newOwner address) returns()
func (_Casper *CasperTransactorSession) SetNewOwner(newOwner common.Address) (*types.Transaction, error) {
	return _Casper.Contract.SetNewOwner(&_Casper.TransactOpts, newOwner)
}

// SetPrice is a paid mutator transaction binding the contract method 0x91b7f5ed.
//
// Solidity: function setPrice(newPrice uint256) returns()
func (_Casper *CasperTransactor) SetPrice(opts *bind.TransactOpts, newPrice *big.Int) (*types.Transaction, error) {
	return _Casper.contract.Transact(opts, "setPrice", newPrice)
}

// SetPrice is a paid mutator transaction binding the contract method 0x91b7f5ed.
//
// Solidity: function setPrice(newPrice uint256) returns()
func (_Casper *CasperSession) SetPrice(newPrice *big.Int) (*types.Transaction, error) {
	return _Casper.Contract.SetPrice(&_Casper.TransactOpts, newPrice)
}

// SetPrice is a paid mutator transaction binding the contract method 0x91b7f5ed.
//
// Solidity: function setPrice(newPrice uint256) returns()
func (_Casper *CasperTransactorSession) SetPrice(newPrice *big.Int) (*types.Transaction, error) {
	return _Casper.Contract.SetPrice(&_Casper.TransactOpts, newPrice)
}

// SetTrusted is a paid mutator transaction binding the contract method 0x19240661.
//
// Solidity: function setTrusted(addr address) returns()
func (_Casper *CasperTransactor) SetTrusted(opts *bind.TransactOpts, addr common.Address) (*types.Transaction, error) {
	return _Casper.contract.Transact(opts, "setTrusted", addr)
}

// SetTrusted is a paid mutator transaction binding the contract method 0x19240661.
//
// Solidity: function setTrusted(addr address) returns()
func (_Casper *CasperSession) SetTrusted(addr common.Address) (*types.Transaction, error) {
	return _Casper.Contract.SetTrusted(&_Casper.TransactOpts, addr)
}

// SetTrusted is a paid mutator transaction binding the contract method 0x19240661.
//
// Solidity: function setTrusted(addr address) returns()
func (_Casper *CasperTransactorSession) SetTrusted(addr common.Address) (*types.Transaction, error) {
	return _Casper.Contract.SetTrusted(&_Casper.TransactOpts, addr)
}

// WithdrawEther is a paid mutator transaction binding the contract method 0x3bed33ce.
//
// Solidity: function withdrawEther(eth uint256) returns()
func (_Casper *CasperTransactor) WithdrawEther(opts *bind.TransactOpts, eth *big.Int) (*types.Transaction, error) {
	return _Casper.contract.Transact(opts, "withdrawEther", eth)
}

// WithdrawEther is a paid mutator transaction binding the contract method 0x3bed33ce.
//
// Solidity: function withdrawEther(eth uint256) returns()
func (_Casper *CasperSession) WithdrawEther(eth *big.Int) (*types.Transaction, error) {
	return _Casper.Contract.WithdrawEther(&_Casper.TransactOpts, eth)
}

// WithdrawEther is a paid mutator transaction binding the contract method 0x3bed33ce.
//
// Solidity: function withdrawEther(eth uint256) returns()
func (_Casper *CasperTransactorSession) WithdrawEther(eth *big.Int) (*types.Transaction, error) {
	return _Casper.Contract.WithdrawEther(&_Casper.TransactOpts, eth)
}

// PresaleABI is the input ABI used to generate the binding from.
const PresaleABI = "[{\"inputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"}]"

// PresaleBin is the compiled bytecode used for deploying new contracts.
const PresaleBin = `0x608060405260008055348015601357600080fd5b5060437341c8f018d10f500d231f723017389da5ff9f45f269040ecd1bdeb946da00006401000000006047810204565b608d565b6000805481526001602081815260408084208054600160a060020a03909716600160a060020a031990971687179055948352600290529281209190915580549091019055565b603580609a6000396000f3006080604052600080fd00a165627a7a723058209980dee7c3331486c65fa498aee8dd36b800d357197a8ea11ec6bf248acb36930029`

// DeployPresale deploys a new Ethereum contract, binding an instance of Presale to it.
func DeployPresale(auth *bind.TransactOpts, backend bind.ContractBackend) (common.Address, *types.Transaction, *Presale, error) {
	parsed, err := abi.JSON(strings.NewReader(PresaleABI))
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	address, tx, contract, err := bind.DeployContract(auth, parsed, common.FromHex(PresaleBin), backend)
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	return address, tx, &Presale{PresaleCaller: PresaleCaller{contract: contract}, PresaleTransactor: PresaleTransactor{contract: contract}, PresaleFilterer: PresaleFilterer{contract: contract}}, nil
}

// Presale is an auto generated Go binding around an Ethereum contract.
type Presale struct {
	PresaleCaller     // Read-only binding to the contract
	PresaleTransactor // Write-only binding to the contract
	PresaleFilterer   // Log filterer for contract events
}

// PresaleCaller is an auto generated read-only Go binding around an Ethereum contract.
type PresaleCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// PresaleTransactor is an auto generated write-only Go binding around an Ethereum contract.
type PresaleTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// PresaleFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type PresaleFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// PresaleSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type PresaleSession struct {
	Contract     *Presale          // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// PresaleCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type PresaleCallerSession struct {
	Contract *PresaleCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts  // Call options to use throughout this session
}

// PresaleTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type PresaleTransactorSession struct {
	Contract     *PresaleTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts  // Transaction auth options to use throughout this session
}

// PresaleRaw is an auto generated low-level Go binding around an Ethereum contract.
type PresaleRaw struct {
	Contract *Presale // Generic contract binding to access the raw methods on
}

// PresaleCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type PresaleCallerRaw struct {
	Contract *PresaleCaller // Generic read-only contract binding to access the raw methods on
}

// PresaleTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type PresaleTransactorRaw struct {
	Contract *PresaleTransactor // Generic write-only contract binding to access the raw methods on
}

// NewPresale creates a new instance of Presale, bound to a specific deployed contract.
func NewPresale(address common.Address, backend bind.ContractBackend) (*Presale, error) {
	contract, err := bindPresale(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &Presale{PresaleCaller: PresaleCaller{contract: contract}, PresaleTransactor: PresaleTransactor{contract: contract}, PresaleFilterer: PresaleFilterer{contract: contract}}, nil
}

// NewPresaleCaller creates a new read-only instance of Presale, bound to a specific deployed contract.
func NewPresaleCaller(address common.Address, caller bind.ContractCaller) (*PresaleCaller, error) {
	contract, err := bindPresale(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &PresaleCaller{contract: contract}, nil
}

// NewPresaleTransactor creates a new write-only instance of Presale, bound to a specific deployed contract.
func NewPresaleTransactor(address common.Address, transactor bind.ContractTransactor) (*PresaleTransactor, error) {
	contract, err := bindPresale(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &PresaleTransactor{contract: contract}, nil
}

// NewPresaleFilterer creates a new log filterer instance of Presale, bound to a specific deployed contract.
func NewPresaleFilterer(address common.Address, filterer bind.ContractFilterer) (*PresaleFilterer, error) {
	contract, err := bindPresale(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &PresaleFilterer{contract: contract}, nil
}

// bindPresale binds a generic wrapper to an already deployed contract.
func bindPresale(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := abi.JSON(strings.NewReader(PresaleABI))
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Presale *PresaleRaw) Call(opts *bind.CallOpts, result interface{}, method string, params ...interface{}) error {
	return _Presale.Contract.PresaleCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Presale *PresaleRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Presale.Contract.PresaleTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Presale *PresaleRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Presale.Contract.PresaleTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Presale *PresaleCallerRaw) Call(opts *bind.CallOpts, result interface{}, method string, params ...interface{}) error {
	return _Presale.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Presale *PresaleTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Presale.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Presale *PresaleTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Presale.Contract.contract.Transact(opts, method, params...)
}

// PrivilegesABI is the input ABI used to generate the binding from.
const PrivilegesABI = "[{\"constant\":false,\"inputs\":[{\"name\":\"addr\",\"type\":\"address\"}],\"name\":\"setTrusted\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"trusted\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"setNewOwner\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[],\"payable\":true,\"stateMutability\":\"payable\",\"type\":\"constructor\"}]"

// PrivilegesBin is the compiled bytecode used for deploying new contracts.
const PrivilegesBin = `0x608060405260008054600160a060020a033316600160a060020a03199091161790556101ce806100306000396000f3006080604052600436106100615763ffffffff7c01000000000000000000000000000000000000000000000000000000006000350416631924066181146100665780637e2a6db8146100895780638da5cb5b146100ba578063f5a1f5b4146100cf575b600080fd5b34801561007257600080fd5b50610087600160a060020a03600435166100f0565b005b34801561009557600080fd5b5061009e61013a565b60408051600160a060020a039092168252519081900360200190f35b3480156100c657600080fd5b5061009e610149565b3480156100db57600080fd5b50610087600160a060020a0360043516610158565b60005433600160a060020a0390811691161461010b57600080fd5b6001805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0392909216919091179055565b600154600160a060020a031681565b600054600160a060020a031681565b60005433600160a060020a0390811691161461017357600080fd5b6000805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a03929092169190911790555600a165627a7a723058200abaec7a76185554fcc8993937688833f343ac8caf7d9fde4c5d98622b88c0bf0029`

// DeployPrivileges deploys a new Ethereum contract, binding an instance of Privileges to it.
func DeployPrivileges(auth *bind.TransactOpts, backend bind.ContractBackend) (common.Address, *types.Transaction, *Privileges, error) {
	parsed, err := abi.JSON(strings.NewReader(PrivilegesABI))
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	address, tx, contract, err := bind.DeployContract(auth, parsed, common.FromHex(PrivilegesBin), backend)
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	return address, tx, &Privileges{PrivilegesCaller: PrivilegesCaller{contract: contract}, PrivilegesTransactor: PrivilegesTransactor{contract: contract}, PrivilegesFilterer: PrivilegesFilterer{contract: contract}}, nil
}

// Privileges is an auto generated Go binding around an Ethereum contract.
type Privileges struct {
	PrivilegesCaller     // Read-only binding to the contract
	PrivilegesTransactor // Write-only binding to the contract
	PrivilegesFilterer   // Log filterer for contract events
}

// PrivilegesCaller is an auto generated read-only Go binding around an Ethereum contract.
type PrivilegesCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// PrivilegesTransactor is an auto generated write-only Go binding around an Ethereum contract.
type PrivilegesTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// PrivilegesFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type PrivilegesFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// PrivilegesSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type PrivilegesSession struct {
	Contract     *Privileges       // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// PrivilegesCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type PrivilegesCallerSession struct {
	Contract *PrivilegesCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts     // Call options to use throughout this session
}

// PrivilegesTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type PrivilegesTransactorSession struct {
	Contract     *PrivilegesTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts     // Transaction auth options to use throughout this session
}

// PrivilegesRaw is an auto generated low-level Go binding around an Ethereum contract.
type PrivilegesRaw struct {
	Contract *Privileges // Generic contract binding to access the raw methods on
}

// PrivilegesCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type PrivilegesCallerRaw struct {
	Contract *PrivilegesCaller // Generic read-only contract binding to access the raw methods on
}

// PrivilegesTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type PrivilegesTransactorRaw struct {
	Contract *PrivilegesTransactor // Generic write-only contract binding to access the raw methods on
}

// NewPrivileges creates a new instance of Privileges, bound to a specific deployed contract.
func NewPrivileges(address common.Address, backend bind.ContractBackend) (*Privileges, error) {
	contract, err := bindPrivileges(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &Privileges{PrivilegesCaller: PrivilegesCaller{contract: contract}, PrivilegesTransactor: PrivilegesTransactor{contract: contract}, PrivilegesFilterer: PrivilegesFilterer{contract: contract}}, nil
}

// NewPrivilegesCaller creates a new read-only instance of Privileges, bound to a specific deployed contract.
func NewPrivilegesCaller(address common.Address, caller bind.ContractCaller) (*PrivilegesCaller, error) {
	contract, err := bindPrivileges(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &PrivilegesCaller{contract: contract}, nil
}

// NewPrivilegesTransactor creates a new write-only instance of Privileges, bound to a specific deployed contract.
func NewPrivilegesTransactor(address common.Address, transactor bind.ContractTransactor) (*PrivilegesTransactor, error) {
	contract, err := bindPrivileges(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &PrivilegesTransactor{contract: contract}, nil
}

// NewPrivilegesFilterer creates a new log filterer instance of Privileges, bound to a specific deployed contract.
func NewPrivilegesFilterer(address common.Address, filterer bind.ContractFilterer) (*PrivilegesFilterer, error) {
	contract, err := bindPrivileges(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &PrivilegesFilterer{contract: contract}, nil
}

// bindPrivileges binds a generic wrapper to an already deployed contract.
func bindPrivileges(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := abi.JSON(strings.NewReader(PrivilegesABI))
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Privileges *PrivilegesRaw) Call(opts *bind.CallOpts, result interface{}, method string, params ...interface{}) error {
	return _Privileges.Contract.PrivilegesCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Privileges *PrivilegesRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Privileges.Contract.PrivilegesTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Privileges *PrivilegesRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Privileges.Contract.PrivilegesTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_Privileges *PrivilegesCallerRaw) Call(opts *bind.CallOpts, result interface{}, method string, params ...interface{}) error {
	return _Privileges.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_Privileges *PrivilegesTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _Privileges.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_Privileges *PrivilegesTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _Privileges.Contract.contract.Transact(opts, method, params...)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() constant returns(address)
func (_Privileges *PrivilegesCaller) Owner(opts *bind.CallOpts) (common.Address, error) {
	var (
		ret0 = new(common.Address)
	)
	out := ret0
	err := _Privileges.contract.Call(opts, out, "owner")
	return *ret0, err
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() constant returns(address)
func (_Privileges *PrivilegesSession) Owner() (common.Address, error) {
	return _Privileges.Contract.Owner(&_Privileges.CallOpts)
}

// Owner is a free data retrieval call binding the contract method 0x8da5cb5b.
//
// Solidity: function owner() constant returns(address)
func (_Privileges *PrivilegesCallerSession) Owner() (common.Address, error) {
	return _Privileges.Contract.Owner(&_Privileges.CallOpts)
}

// Trusted is a free data retrieval call binding the contract method 0x7e2a6db8.
//
// Solidity: function trusted() constant returns(address)
func (_Privileges *PrivilegesCaller) Trusted(opts *bind.CallOpts) (common.Address, error) {
	var (
		ret0 = new(common.Address)
	)
	out := ret0
	err := _Privileges.contract.Call(opts, out, "trusted")
	return *ret0, err
}

// Trusted is a free data retrieval call binding the contract method 0x7e2a6db8.
//
// Solidity: function trusted() constant returns(address)
func (_Privileges *PrivilegesSession) Trusted() (common.Address, error) {
	return _Privileges.Contract.Trusted(&_Privileges.CallOpts)
}

// Trusted is a free data retrieval call binding the contract method 0x7e2a6db8.
//
// Solidity: function trusted() constant returns(address)
func (_Privileges *PrivilegesCallerSession) Trusted() (common.Address, error) {
	return _Privileges.Contract.Trusted(&_Privileges.CallOpts)
}

// SetNewOwner is a paid mutator transaction binding the contract method 0xf5a1f5b4.
//
// Solidity: function setNewOwner(newOwner address) returns()
func (_Privileges *PrivilegesTransactor) SetNewOwner(opts *bind.TransactOpts, newOwner common.Address) (*types.Transaction, error) {
	return _Privileges.contract.Transact(opts, "setNewOwner", newOwner)
}

// SetNewOwner is a paid mutator transaction binding the contract method 0xf5a1f5b4.
//
// Solidity: function setNewOwner(newOwner address) returns()
func (_Privileges *PrivilegesSession) SetNewOwner(newOwner common.Address) (*types.Transaction, error) {
	return _Privileges.Contract.SetNewOwner(&_Privileges.TransactOpts, newOwner)
}

// SetNewOwner is a paid mutator transaction binding the contract method 0xf5a1f5b4.
//
// Solidity: function setNewOwner(newOwner address) returns()
func (_Privileges *PrivilegesTransactorSession) SetNewOwner(newOwner common.Address) (*types.Transaction, error) {
	return _Privileges.Contract.SetNewOwner(&_Privileges.TransactOpts, newOwner)
}

// SetTrusted is a paid mutator transaction binding the contract method 0x19240661.
//
// Solidity: function setTrusted(addr address) returns()
func (_Privileges *PrivilegesTransactor) SetTrusted(opts *bind.TransactOpts, addr common.Address) (*types.Transaction, error) {
	return _Privileges.contract.Transact(opts, "setTrusted", addr)
}

// SetTrusted is a paid mutator transaction binding the contract method 0x19240661.
//
// Solidity: function setTrusted(addr address) returns()
func (_Privileges *PrivilegesSession) SetTrusted(addr common.Address) (*types.Transaction, error) {
	return _Privileges.Contract.SetTrusted(&_Privileges.TransactOpts, addr)
}

// SetTrusted is a paid mutator transaction binding the contract method 0x19240661.
//
// Solidity: function setTrusted(addr address) returns()
func (_Privileges *PrivilegesTransactorSession) SetTrusted(addr common.Address) (*types.Transaction, error) {
	return _Privileges.Contract.SetTrusted(&_Privileges.TransactOpts, addr)
}

// SafeMathABI is the input ABI used to generate the binding from.
const SafeMathABI = "[]"

// SafeMathBin is the compiled bytecode used for deploying new contracts.
const SafeMathBin = `0x6080604052348015600f57600080fd5b50603580601d6000396000f3006080604052600080fd00a165627a7a72305820c4f14b241c2f9fae0ca4b301f2817a937ab087d84f719baf987c8e417ece70650029`

// DeploySafeMath deploys a new Ethereum contract, binding an instance of SafeMath to it.
func DeploySafeMath(auth *bind.TransactOpts, backend bind.ContractBackend) (common.Address, *types.Transaction, *SafeMath, error) {
	parsed, err := abi.JSON(strings.NewReader(SafeMathABI))
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	address, tx, contract, err := bind.DeployContract(auth, parsed, common.FromHex(SafeMathBin), backend)
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	return address, tx, &SafeMath{SafeMathCaller: SafeMathCaller{contract: contract}, SafeMathTransactor: SafeMathTransactor{contract: contract}, SafeMathFilterer: SafeMathFilterer{contract: contract}}, nil
}

// SafeMath is an auto generated Go binding around an Ethereum contract.
type SafeMath struct {
	SafeMathCaller     // Read-only binding to the contract
	SafeMathTransactor // Write-only binding to the contract
	SafeMathFilterer   // Log filterer for contract events
}

// SafeMathCaller is an auto generated read-only Go binding around an Ethereum contract.
type SafeMathCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// SafeMathTransactor is an auto generated write-only Go binding around an Ethereum contract.
type SafeMathTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// SafeMathFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type SafeMathFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// SafeMathSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type SafeMathSession struct {
	Contract     *SafeMath         // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// SafeMathCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type SafeMathCallerSession struct {
	Contract *SafeMathCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts   // Call options to use throughout this session
}

// SafeMathTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type SafeMathTransactorSession struct {
	Contract     *SafeMathTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts   // Transaction auth options to use throughout this session
}

// SafeMathRaw is an auto generated low-level Go binding around an Ethereum contract.
type SafeMathRaw struct {
	Contract *SafeMath // Generic contract binding to access the raw methods on
}

// SafeMathCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type SafeMathCallerRaw struct {
	Contract *SafeMathCaller // Generic read-only contract binding to access the raw methods on
}

// SafeMathTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type SafeMathTransactorRaw struct {
	Contract *SafeMathTransactor // Generic write-only contract binding to access the raw methods on
}

// NewSafeMath creates a new instance of SafeMath, bound to a specific deployed contract.
func NewSafeMath(address common.Address, backend bind.ContractBackend) (*SafeMath, error) {
	contract, err := bindSafeMath(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &SafeMath{SafeMathCaller: SafeMathCaller{contract: contract}, SafeMathTransactor: SafeMathTransactor{contract: contract}, SafeMathFilterer: SafeMathFilterer{contract: contract}}, nil
}

// NewSafeMathCaller creates a new read-only instance of SafeMath, bound to a specific deployed contract.
func NewSafeMathCaller(address common.Address, caller bind.ContractCaller) (*SafeMathCaller, error) {
	contract, err := bindSafeMath(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &SafeMathCaller{contract: contract}, nil
}

// NewSafeMathTransactor creates a new write-only instance of SafeMath, bound to a specific deployed contract.
func NewSafeMathTransactor(address common.Address, transactor bind.ContractTransactor) (*SafeMathTransactor, error) {
	contract, err := bindSafeMath(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &SafeMathTransactor{contract: contract}, nil
}

// NewSafeMathFilterer creates a new log filterer instance of SafeMath, bound to a specific deployed contract.
func NewSafeMathFilterer(address common.Address, filterer bind.ContractFilterer) (*SafeMathFilterer, error) {
	contract, err := bindSafeMath(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &SafeMathFilterer{contract: contract}, nil
}

// bindSafeMath binds a generic wrapper to an already deployed contract.
func bindSafeMath(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := abi.JSON(strings.NewReader(SafeMathABI))
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_SafeMath *SafeMathRaw) Call(opts *bind.CallOpts, result interface{}, method string, params ...interface{}) error {
	return _SafeMath.Contract.SafeMathCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_SafeMath *SafeMathRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _SafeMath.Contract.SafeMathTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_SafeMath *SafeMathRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _SafeMath.Contract.SafeMathTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_SafeMath *SafeMathCallerRaw) Call(opts *bind.CallOpts, result interface{}, method string, params ...interface{}) error {
	return _SafeMath.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_SafeMath *SafeMathTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _SafeMath.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_SafeMath *SafeMathTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _SafeMath.Contract.contract.Transact(opts, method, params...)
}
