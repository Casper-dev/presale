package main

import (
	"encoding/csv"
	"fmt"
	"log"
	"math/big"
	"os"

	preico "./preico"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
)

const ContractAddress = "9195c0345c5c6b88e71e5d3693ca9f5c2ca3b335"
const preicoRecords = "export-0x9195c0345c5c6b88e71e5d3693ca9f5c2ca3b335.csv"

var tokens = make(map[string]*big.Int)

func main() {
	fp, _ := os.Open(preicoRecords)
	r := csv.NewReader(fp)
	records, err := r.ReadAll()
	if err != nil {
		log.Fatal(err)
	}

	client, err := ethclient.Dial("https://mainnet.infura.io/A1DY7JSwA01Sr5OdsRtc")
	if err != nil {
		log.Fatal(err)
	}

	scAddr := common.HexToAddress(ContractAddress)
	c, err := preico.NewCasper(scAddr, client)
	for _, s := range records {
		a := common.HexToAddress(s[4])
		b, err := c.BalanceOf(nil, a)
		if err != nil {
			log.Fatal(err)
		}

		if t := tokens[a.String()]; t != nil {
			t.Add(t, b)
		} else {
			tokens[a.String()] = b
		}
	}

	s := big.NewInt(0)
	for a, t := range tokens {
		fmt.Printf("%s: %s\n", a, t)
		s.Add(s, t)
	}
	fmt.Printf("%s %f", s, s)

}
