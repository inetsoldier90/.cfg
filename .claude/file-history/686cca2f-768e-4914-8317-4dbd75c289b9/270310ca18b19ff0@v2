# Go Auction Platform — Learning Roadmap

A step-by-step project to learn Go, concurrency, and WebSockets by building a real-time auction platform.

Each challenge is small enough to finish in one or two evenings.
Run `go run .` inside any challenge directory to test your work.

---

## Phase 1 — Get Comfortable with Go
> Goal: feel at home with Go's syntax and idioms before touching concurrency or networking.

### Challenge 1.1 — CLI Calculator
`challenges/phase1/1.1-calculator/`

Build a command-line calculator that takes two numbers and an operator as arguments.
```
go run . 10 + 5   → 15
go run . 10 / 0   → error: division by zero
```
- Learn: basic types, functions, `os.Args`, `switch` statements
- Key difference from Java/Kotlin: no exceptions — handle errors with `(value, error)` return values

### Challenge 1.2 — Struct-based Auction Item
`challenges/phase1/1.2-auction-item/`

Model an `AuctionItem` struct with name, starting price, and current bid.
Write methods: `PlaceBid(amount float64) error`, `CurrentPrice() float64`.
- Learn: structs, methods, value vs pointer receivers
- Key difference: no classes, no inheritance — just structs and methods

### Challenge 1.3 — Interface for Notifier
`challenges/phase1/1.3-notifier/`

Define a `Notifier` interface with a `Notify(message string)` method.
Implement two versions: `ConsoleNotifier` (prints to stdout) and `FileNotifier` (writes to a file).
- Learn: interfaces, how Go does polymorphism
- Key difference: interfaces are implicit — no `implements` keyword

### Challenge 1.4 — In-Memory Auction Store
`challenges/phase1/1.4-auction-store/`

Build a store that holds multiple `AuctionItem`s in a map.
Add operations: `Create`, `Get`, `List`, `Close`.
- Learn: maps, slices, error handling patterns, `fmt.Errorf`
- Goal: you now have the domain model for the full project

---

## Phase 2 — Concurrency Fundamentals
> Goal: understand goroutines and channels before applying them to WebSockets.

### Challenge 2.1 — Concurrent Bid Simulator
`challenges/phase2/2.1-bid-simulator/`

Simulate 10 users bidding on an item at the same time using goroutines. Print who won.
- Learn: `go` keyword, `sync.WaitGroup`
- Tip: introduce the race condition intentionally first, observe the chaos

### Challenge 2.2 — Fix the Race Condition
`challenges/phase2/2.2-race-fix/`

Take Challenge 2.1 and protect the shared auction state.
```
go run -race .
```
- Learn: `sync.Mutex`, when to use it, the `-race` flag
- Key insight: Go's race detector is a first-class tool — use it constantly

### Challenge 2.3 — Channel-based Bid Pipeline
`challenges/phase2/2.3-channel-pipeline/`

Refactor so bidders send bids into a channel instead of calling a method directly.
One goroutine reads from the channel and applies bids sequentially.
- Learn: channels, the "single owner of state" pattern
- Key insight: this pattern replaces mutexes in idiomatic Go

### Challenge 2.4 — Auction Timer
`challenges/phase2/2.4-auction-timer/`

Add a countdown to an auction using `time.NewTicker` and `time.After`.
When time expires, close the auction automatically.
- Learn: `time` package, `select` statement with multiple channels
- Key insight: `select` is how Go goroutines wait on multiple things at once

### Challenge 2.5 — Fan-out Broadcaster
`challenges/phase2/2.5-fan-out/`

One goroutine generates bid events. Multiple subscriber goroutines each receive every event.
- Learn: fan-out pattern, buffered vs unbuffered channels
- Key insight: this is the exact pattern the WebSocket hub will use
- Experiment: what happens when a slow subscriber blocks?

---

## Phase 3 — HTTP and WebSockets
> Goal: learn Go's HTTP model and get WebSockets working before adding auction logic.

### Challenge 3.1 — Simple HTTP Server
`challenges/phase3/3.1-http-server/`

Serve a hardcoded JSON list of auctions at `GET /auctions`. No framework — stdlib only.
- Learn: `http.HandleFunc`, `http.ListenAndServe`, `json.Marshal`
- Key insight: Go's stdlib HTTP is production-grade, frameworks are rarely needed

### Challenge 3.2 — WebSocket Echo Server
`challenges/phase3/3.2-echo-server/`

Accept a WebSocket connection and echo every message back to the sender.
Use the `gorilla/websocket` package.
- Learn: upgrading HTTP to WebSocket, reading/writing messages, connection lifecycle
- Goal: connect with a browser/wscat, send "hello", get "hello" back

### Challenge 3.3 — Broadcast Chat
`challenges/phase3/3.3-broadcast-chat/`

Multiple clients connect. Any message sent by one client is broadcast to all others.
- Learn: the **Hub pattern** — a central goroutine owns a map of connections, workers send into it via a channel
- This is the most important Go pattern in this project

### Challenge 3.4 — Graceful Disconnect
`challenges/phase3/3.4-graceful-disconnect/`

Handle clients disconnecting cleanly without crashing the server.
Test by closing the browser tab mid-session.
- Learn: `context`, channel close signals, deferred cleanup
- Key insight: a closed channel is how you broadcast a shutdown signal in Go

---

## Phase 4 — The Auction Platform
> Goal: combine everything into the full project under `cmd/server/`.

### Challenge 4.1 — Auction Rooms
Extend the hub so clients join a specific auction room.
Messages only broadcast within a room.
- Combines: hub pattern + map of rooms + goroutine per room

### Challenge 4.2 — Live Bidding
Wire up the `AuctionItem` domain model to the WebSocket hub.
Clients send a bid — all clients in the room see the new highest bid instantly.
- Combines: domain model + channels + broadcast

### Challenge 4.3 — Countdown Timer over WebSocket
When an auction starts, broadcast a countdown tick every second to all connected clients.
Auto-close the auction at zero.
- Combines: `time.Ticker` + fan-out + room broadcast

### Challenge 4.4 — Late Joiner State Sync
When a client connects to an in-progress auction, immediately send them the current state
(time remaining, current bid, item details).
- Learn: why state sync is hard in real-time systems, and one clean solution

### Challenge 4.5 — Race Detector Clean Pass
Run the full server under `go run -race .` and `go test -race ./...`.
Fix every data race reported.
- Goal: ship code you'd be confident putting in production

---

## Resources

- [A Tour of Go](https://tour.golang.org) — do this alongside Phase 1, takes ~2 hours
- [Go by Example](https://gobyexample.com) — reference for any syntax you're unsure about
- [gorilla/websocket](https://github.com/gorilla/websocket) — WebSocket library used in Phase 3+
- [Effective Go](https://go.dev/doc/effective_go) — idiomatic Go patterns, read after Phase 2
