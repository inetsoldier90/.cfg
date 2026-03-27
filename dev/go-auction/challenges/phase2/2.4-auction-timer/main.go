package main

import (
	"fmt"
	"time"
)

// Challenge 2.4 — Auction Timer
//
// Add a countdown timer to an auction. The auction closes automatically when time runs out.
// Combine the channel pipeline from 2.3 with a timer.
//
// Steps:
//   1. Start a countdown: deadline := time.After(10 * time.Second)
//   2. Start a tick for display: ticker := time.NewTicker(1 * time.Second)
//   3. In the processor goroutine, use a select statement to handle three cases:
//        case bid := <-bidCh         — process incoming bid
//        case <-ticker.C             — print time remaining
//        case <-deadline             — close the auction, stop processing
//   4. Simulate bids arriving at random intervals from a separate goroutine
//
// Key things to notice:
//   - select blocks until ONE of the cases is ready — like a switch for channels
//   - time.After returns a channel that receives once after the duration
//   - time.NewTicker returns a channel that receives repeatedly on an interval
//   - select with a default case becomes non-blocking — useful but easy to misuse
//
// Experiment: what happens if you use a 0-duration ticker? Or a very slow bid sender?

func main() {
	bidCh := make(chan Bid, 5) // buffered so senders don't block

	// TODO: launch bid sender goroutine — sends random bids every 1-3 seconds for 15 seconds

	// TODO: run the auction processor with select, handling bids + ticker + deadline

	fmt.Println("Auction finished.")
}

type Bid struct {
	UserID int
	Amount float64
}
