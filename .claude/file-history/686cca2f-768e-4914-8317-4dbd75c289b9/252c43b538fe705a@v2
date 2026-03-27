package main

import (
	"log"
	"net/http"

	"github.com/gorilla/websocket"
)

// Challenge 3.2 — WebSocket Echo Server
//
// Accept a WebSocket connection and echo every message back to the sender.
//
// Steps:
//   1. Create a websocket.Upgrader (set CheckOrigin to allow all for now)
//   2. In the handler: upgrade the HTTP connection to WebSocket
//   3. Read messages in a loop: messageType, p, err := conn.ReadMessage()
//   4. Write the same message back: conn.WriteMessage(messageType, p)
//   5. Break the loop when err != nil (client disconnected)
//
// Test it with wscat (install: npm install -g wscat):
//   wscat -c ws://localhost:8080/ws
//   > hello
//   < hello
//
// Or open your browser console and run:
//   const ws = new WebSocket("ws://localhost:8080/ws")
//   ws.onmessage = e => console.log("received:", e.data)
//   ws.send("hello")
//
// Key things to notice:
//   - WebSocket starts as an HTTP request that gets "upgraded"
//   - The upgrader switches the protocol from HTTP to WebSocket
//   - ReadMessage blocks until a message arrives — perfect for a goroutine
//   - Always handle the disconnect error — clients drop without warning

var upgrader = websocket.Upgrader{
	// TODO: set CheckOrigin to return true (allow all origins for development)
}

func main() {
	http.HandleFunc("/ws", handleWS)
	http.HandleFunc("/", serveHome)

	log.Println("Server started on :8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func handleWS(w http.ResponseWriter, r *http.Request) {
	// TODO: upgrade the connection
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println("upgrade error:", err)
		return
	}
	defer conn.Close()

	log.Println("Client connected:", r.RemoteAddr)

	for {
		// TODO: read message
		// TODO: log it
		// TODO: echo it back
		// TODO: break on error
	}
}

// serveHome serves a simple HTML page with a WebSocket test UI
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
    ws.onmessage = e => document.getElementById("log").textContent += "< " + e.data + "\n";
    function send() {
      const msg = document.getElementById("msg").value;
      ws.send(msg);
      document.getElementById("log").textContent += "> " + msg + "\n";
    }
  </script>
</body>
</html>`))
}
