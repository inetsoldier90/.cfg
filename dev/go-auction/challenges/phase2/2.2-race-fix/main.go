package main

import (
	"fmt"
	"math/rand"
	"sync"
	"time"
)

// Challenge 2.2 — Fix the Race Condition
//
// Take the simulator from 2.1 and protect the shared auction state.
//
// Steps:
//   1. Add a sync.Mutex to AuctionItem
//   2. Lock before reading/writing currentBid, unlock after
//   3. Run again with the race detector — it should be clean:
//        go run -race .
//
// Key things to notice:
//   - mu.Lock() / mu.Unlock() — always pair these, use defer mu.Unlock() to be safe
//   - The race detector output disappears once all shared state is protected
//   - Performance: mutexes serialize access — only one goroutine at a time
//
// Experiment: what happens if you forget to unlock? (deadlock — the program hangs)

func main() {
	rand.New(rand.NewSource(time.Now().UnixNano()))

	item := NewAuctionItem("Vintage Watch", 100.0)
	var wg sync.WaitGroup

	for i := range 10 {
		wg.Add(1)
		go func(userID int) {
			defer wg.Done()
			bid := 100.0 + float64(rand.Intn(200))
			if item.PlaceBid(userID, bid) {
				fmt.Printf("User %d is now winning with $%.2f\n", userID, bid)
			}
		}(i)
	}

	wg.Wait()
	fmt.Printf("\nAuction closed. Winner: User %d at $%.2f\n", item.winner, item.currentBid)
}

type AuctionItem struct {
	Name       string
	currentBid float64
	winner     int
	// TODO: add a sync.Mutex field here
}

func NewAuctionItem(name string, startingPrice float64) *AuctionItem {
	return &AuctionItem{Name: name, currentBid: startingPrice}
}

// TODO: implement PlaceBid(userID int, amount float64) bool
// Lock, check if amount > currentBid, update if so, unlock, return whether bid was accepted
func (a *AuctionItem) PlaceBid(userID int, amount float64) bool {
	// TODO: implement with mutex protection
	return false
}
