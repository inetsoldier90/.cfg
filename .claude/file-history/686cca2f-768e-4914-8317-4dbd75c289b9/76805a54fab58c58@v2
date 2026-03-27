package main

import (
	"fmt"
	"math/rand"
	"time"
)

// Challenge 2.3 — Channel-based Bid Pipeline
//
// Refactor so bidders send bids into a channel instead of calling a method directly.
// A single goroutine reads from the channel and applies bids sequentially.
//
// This eliminates the need for a mutex entirely — only one goroutine ever touches the state.
//
// Steps:
//   1. Define a Bid struct: { UserID int, Amount float64 }
//   2. Create a bidCh := make(chan Bid) channel
//   3. Launch a "processor" goroutine that reads from bidCh in a for-range loop
//      and updates the auction state
//   4. Launch 10 "bidder" goroutines that send into bidCh
//   5. Close the channel when all bidders are done (use sync.WaitGroup for bidders)
//   6. Wait for the processor to finish, then print the winner
//
// Key things to notice:
//   - `for bid := range bidCh` reads until the channel is closed
//   - Closing a channel signals "no more values" — the for-range exits cleanly
//   - The processor goroutine never needs a mutex because it's the only reader+writer
//   - This is the idiomatic Go approach: "share memory by communicating"

type Bid struct {
	UserID int
	Amount float64
}

func main() {
	rand.New(rand.NewSource(time.Now().UnixNano()))

	bidCh := make(chan Bid)

	currentBid := 100.0
	winner := -1

	// TODO: launch processor goroutine — reads from bidCh, updates currentBid and winner

	// TODO: launch 10 bidder goroutines — each sends one bid into bidCh

	// TODO: wait for all bidders to finish, then close(bidCh)

	// TODO: wait for processor to finish

	fmt.Printf("Auction closed. Winner: User %d at $%.2f\n", winner, currentBid)
}
