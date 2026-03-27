package main

import (
	"encoding/json"
	"log"
	"net/http"
)

// Challenge 3.1 — Simple HTTP Server
//
// Serve a JSON list of auctions at GET /auctions.
// No frameworks — standard library only.
//
// Steps:
//   1. Define an Auction struct with json tags: `json:"id"` etc.
//   2. Create a hardcoded list of auctions
//   3. Register a handler with http.HandleFunc("/auctions", handler)
//   4. In the handler: set Content-Type header, encode to JSON, write response
//   5. Start the server: http.ListenAndServe(":8080", nil)
//
// Test it:
//   curl http://localhost:8080/auctions
//
// Steps to extend (optional):
//   - Add GET /auctions/{id} — return a single auction or 404
//   - Add POST /auctions — parse JSON body, add to the list
//
// Key things to notice:
//   - http.ResponseWriter is an interface — Write() and Header() are your tools
//   - http.Request carries method, URL, headers, body — everything you need
//   - json.NewEncoder(w).Encode(v) writes JSON directly to the response writer

type Auction struct {
	ID           string  `json:"id"`
	Name         string  `json:"name"`
	CurrentPrice float64 `json:"currentPrice"`
	Closed       bool    `json:"closed"`
}

var auctions = []Auction{
	{ID: "1", Name: "Vintage Watch", CurrentPrice: 100.0},
	{ID: "2", Name: "Rare Sneakers", CurrentPrice: 200.0},
	{ID: "3", Name: "Old Painting", CurrentPrice: 500.0, Closed: true},
}

func main() {
	// TODO: register handler for GET /auctions
	http.HandleFunc("/auctions", func(w http.ResponseWriter, r *http.Request) {
		// TODO: set Content-Type to application/json
		// TODO: encode auctions as JSON and write to w
		_ = json.NewEncoder(w)
	})

	log.Println("Listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
