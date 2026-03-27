package main

import "fmt"

// Challenge 1.2 — Struct-based Auction Item
//
// Model an AuctionItem and write methods on it.
//
// Steps:
//   1. Define an AuctionItem struct with: ID, Name, StartingPrice, currentBid, closed
//      (unexported fields like currentBid start with lowercase — Go's visibility rule)
//   2. Write a constructor: func NewAuctionItem(id, name string, startingPrice float64) *AuctionItem
//   3. Write PlaceBid(amount float64) error — reject bids lower than current price or if closed
//   4. Write CurrentPrice() float64
//   5. Write Close() and IsClosed() bool
//
// Key things to notice:
//   - Methods are defined outside the struct: func (a *AuctionItem) PlaceBid(...) error
//   - Use a pointer receiver (*AuctionItem) when the method mutates state
//   - Use a value receiver (AuctionItem) when it only reads

func main() {
	// Test your implementation here
	item := NewAuctionItem("1", "Vintage Watch", 100.0)

	fmt.Println("Starting price:", item.CurrentPrice())

	if err := item.PlaceBid(90.0); err != nil {
		fmt.Println("Expected error:", err)
	}

	if err := item.PlaceBid(150.0); err != nil {
		fmt.Println("Error:", err)
	} else {
		fmt.Println("New price:", item.CurrentPrice())
	}

	item.Close()
	if err := item.PlaceBid(200.0); err != nil {
		fmt.Println("Expected error:", err)
	}
}

// TODO: define AuctionItem struct and implement methods below

func NewAuctionItem(id, name string, startingPrice float64) *AuctionItem {
	// TODO: implement
	return nil
}
