package main

import (
	"fmt"
	"sync"
	"time"
)

// Challenge 2.5 — Fan-out Broadcaster
//
// One goroutine produces bid events. Multiple subscriber goroutines each receive every event.
// This is the core pattern behind the WebSocket hub you'll build in Phase 3.
//
// Steps:
//   1. Define a list of subscriber channels: subscribers []chan BidEvent
//   2. Write a broadcast(event BidEvent) function that sends to every subscriber channel
//   3. Launch one producer goroutine that generates bid events
//   4. Launch 3 subscriber goroutines (e.g. "display", "logger", "notifier")
//      each reading from their own channel and printing what they receive
//   5. After N events, close all subscriber channels to signal shutdown
//
// Key things to notice:
//   - Each subscriber gets its own channel — the producer sends to all of them
//   - Use BUFFERED channels (make(chan BidEvent, 10)) so a slow subscriber doesn't block others
//   - Closing a channel wakes up all for-range loops on it — clean shutdown signal
//
// Experiment: make one subscriber artificially slow (time.Sleep). Does it block the others?
// How does buffer size affect this?

type BidEvent struct {
	UserID int
	Amount float64
}

func main() {
	var wg sync.WaitGroup

	// TODO: create subscriber channels (buffered)
	subscribers := []chan BidEvent{
		make(chan BidEvent, 10), // display
		make(chan BidEvent, 10), // logger
		make(chan BidEvent, 10), // notifier
	}

	// TODO: launch subscriber goroutines — each reads its channel and prints received events
	names := []string{"display", "logger", "notifier"}
	for i, sub := range subscribers {
		wg.Add(1)
		go func(name string, ch chan BidEvent) {
			defer wg.Done()
			for event := range ch {
				fmt.Printf("[%s] received bid: User %d — $%.2f\n", name, event.UserID, event.Amount)
				time.Sleep(10 * time.Millisecond) // simulate work
			}
			fmt.Printf("[%s] shutting down\n", name)
		}(names[i], sub)
	}

	// TODO: implement broadcast — sends event to all subscriber channels
	broadcast := func(event BidEvent) {
		// TODO: send event to each subscriber channel
	}

	// Producer: generate 5 bid events
	for i := range 5 {
		broadcast(BidEvent{UserID: i, Amount: float64(100 + i*25)})
		time.Sleep(200 * time.Millisecond)
	}

	// TODO: close all subscriber channels to trigger shutdown

	wg.Wait()
	fmt.Println("All subscribers done.")
}
