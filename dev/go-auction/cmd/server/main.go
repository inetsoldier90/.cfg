package main

// Phase 4 — The Auction Platform
//
// This is where it all comes together.
// Build this incrementally — one challenge at a time.
//
// Challenge 4.1: Auction Rooms
//   Extend the hub so clients join a specific room.
//   Start here: copy your hub from phase3/3.4 and add room support.
//
// Challenge 4.2: Live Bidding
//   Wire the domain model (AuctionItem from phase1/1.4) into the hub.
//   Clients send JSON bids, server validates and broadcasts the new price.
//
// Challenge 4.3: Countdown Timer over WebSocket
//   Broadcast a countdown tick every second to all clients in a room.
//   Auto-close the auction at zero.
//
// Challenge 4.4: Late Joiner State Sync
//   On connect, immediately send the current auction state to the new client.
//
// Challenge 4.5: Race Detector Clean Pass
//   go run -race ./cmd/server/
//   go test -race ./...
//   Fix every reported race.

func main() {
	// TODO: implement Phase 4 challenges here
}
