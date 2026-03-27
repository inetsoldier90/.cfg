package main

import (
	"log"
	"net/http"

	"github.com/gorilla/websocket"
)

// Challenge 3.3 — Broadcast Chat (The Hub Pattern)
//
// Multiple clients connect. Any message from one is broadcast to all others.
// This is THE most important Go pattern in this project.
//
// The Hub pattern:
//   - A central Hub goroutine owns all state (the set of connected clients)
//   - It communicates via channels only — no mutexes needed
//   - Each client connection runs in its own goroutine
//   - Clients register/unregister by sending on hub channels
//
// Steps:
//   1. Define a Client struct: { conn *websocket.Conn, send chan []byte }
//   2. Define a Hub struct:
//        clients    map[*Client]bool
//        broadcast  chan []byte
//        register   chan *Client
//        unregister chan *Client
//   3. Implement Hub.Run() — a goroutine with a select loop handling all three channels
//   4. Each Client has two goroutines:
//        readPump  — reads from WebSocket, sends to hub.broadcast
//        writePump — reads from client.send, writes to WebSocket
//   5. On connect: create Client, register with hub, launch both pumps
//
// Test it: open multiple browser tabs at http://localhost:8080
// Type in one tab — it should appear in all others.
//
// Key things to notice:
//   - The Hub never touches a websocket.Conn directly — only clients do
//   - The Hub never uses a mutex — it's the sole owner of its state
//   - This clean separation of concerns is idiomatic Go

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool { return true },
}

// TODO: define Client struct

// TODO: define Hub struct

// TODO: implement NewHub() *Hub

// TODO: implement Hub.Run() — the central select loop

// TODO: implement client.readPump(hub *Hub)

// TODO: implement client.writePump()

func serveWS(hub *Hub, w http.ResponseWriter, r *http.Request) {
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println(err)
		return
	}
	// TODO: create client, register with hub, launch readPump and writePump
	_ = conn
}

func main() {
	hub := NewHub()
	go hub.Run()

	http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
		serveWS(hub, w, r)
	})
	http.HandleFunc("/", serveHome)

	log.Println("Chat server on :8080 — open multiple tabs")
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func serveHome(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/html")
	w.Write([]byte(`<!DOCTYPE html>
<html>
<body>
  <input id="msg" placeholder="Type a message" />
  <button onclick="send()">Send</button>
  <pre id="log"></pre>
  <script>
    const ws = new WebSocket("ws://" + location.host + "/ws");
    ws.onmessage = e => document.getElementById("log").textContent += e.data + "\n";
    function send() {
      ws.send(document.getElementById("msg").value);
      document.getElementById("msg").value = "";
    }
  </script>
</body>
</html>`))
}
