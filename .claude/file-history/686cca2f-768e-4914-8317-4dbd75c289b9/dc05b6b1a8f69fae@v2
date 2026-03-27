package main

import (
	"fmt"
	"math/rand"
	"sync"
	"time"
)

// Challenge 2.1 — Concurrent Bid Simulator
//
// Simulate 10 users bidding on the same item concurrently using goroutines.
//
// Steps:
//   1. Create an AuctionItem with a starting price
//   2. Launch 10 goroutines, each representing a user placing a random bid
//   3. Use sync.WaitGroup to wait for all goroutines to finish
//   4. Print the final winner (highest bidder)
//
// IMPORTANT: Run this with the race detector and observe:
//   go run -race .
//
// You will likely see a DATA RACE warning. That's intentional for this challenge.
// Don't fix it yet — just observe what happens when goroutines share state unsafely.
// The fix comes in Challenge 2.2.
//
// Key things to notice:
//   - `go someFunc()` launches a goroutine — it runs concurrently, not sequentially
//   - WaitGroup.Add(n) before launching, Done() inside goroutine, Wait() to block until all finish
//   - The output order is non-deterministic — goroutines are not ordered

func main() {
	rand.New(rand.NewSource(time.Now().UnixNano()))

	item := &AuctionItem{Name: "Vintage Watch", currentBid: 100.0}
	var wg sync.WaitGroup

	for i := range 10 {
		wg.Add(1)
		go func(userID int) {
			defer wg.Done()
			bid := 100.0 + float64(rand.Intn(200))
			// TODO: place the bid and print who bid what
			fmt.Printf("User %d bid $%.2f\n", userID, bid)
		}(i)
	}

	wg.Wait()
	fmt.Printf("\nFinal price: $%.2f\n", item.currentBid)
}

// AuctionItem — simplified version for this challenge, no error handling yet
type AuctionItem struct {
	Name       string
	currentBid float64
	winner     int
}

// TODO: implement PlaceBid(userID int, amount float64) — just update currentBid and winner if amount is higher
