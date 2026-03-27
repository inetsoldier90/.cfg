package main

import "fmt"

// Challenge 1.4 — In-Memory Auction Store
//
// Build a store that manages multiple AuctionItems.
// Copy your AuctionItem from 1.2 or rewrite it here.
//
// Steps:
//   1. Define an AuctionStore struct backed by a map[string]*AuctionItem
//   2. Implement:
//        Create(name string, startingPrice float64) *AuctionItem
//        Get(id string) (*AuctionItem, error)
//        List() []*AuctionItem
//        Close(id string) error
//   3. Generate IDs however you like (a counter, uuid, or just "item-1", "item-2")
//
// Key things to notice:
//   - fmt.Errorf("item %s not found", id) is idiomatic Go error creation
//   - Maps are reference types — no need to return a new map after mutation
//   - Returning (nil, error) is the Go equivalent of throwing a NotFoundException

func main() {
	store := NewAuctionStore()

	a := store.Create("Vintage Watch", 100.0)
	b := store.Create("Rare Sneakers", 200.0)

	fmt.Println("All auctions:")
	for _, item := range store.List() {
		fmt.Printf("  [%s] %s — $%.2f\n", item.ID, item.Name, item.CurrentPrice())
	}

	if err := store.Close(a.ID); err != nil {
		fmt.Println("Error:", err)
	}

	if _, err := store.Get("nonexistent"); err != nil {
		fmt.Println("Expected error:", err)
	}

	_ = b
}

// TODO: define AuctionItem (from 1.2) and AuctionStore below

func NewAuctionStore() *AuctionStore {
	// TODO: implement
	return nil
}
