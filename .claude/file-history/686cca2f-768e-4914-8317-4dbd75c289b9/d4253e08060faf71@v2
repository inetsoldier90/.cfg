package main

import (
	"context"
	"log"
	"net/http"
	"time"

	"github.com/gorilla/websocket"
)

// Challenge 3.4 — Graceful Disconnect
//
// Take the broadcast chat from 3.3 and make it handle disconnections cleanly.
// A client closing their browser tab should not crash the server or leave zombie goroutines.
//
// Steps:
//   1. Add write deadline to writePump: conn.SetWriteDeadline(time.Now().Add(10 * time.Second))
//   2. Add pinger to writePump — send a ping every N seconds to detect dead connections:
//        ticker := time.NewTicker(pingInterval)
//        conn.WriteMessage(websocket.PingMessage, nil)
//   3. Set pong handler in readPump to reset the read deadline:
//        conn.SetPongHandler(func(string) error {
//            conn.SetReadDeadline(time.Now().Add(pongWait))
//            return nil
//        })
//   4. Use context.Context for coordinated shutdown:
//        - Pass a ctx to readPump and writePump
//        - When context is cancelled (server shutting down), close the connection cleanly
//   5. In the Hub, handle the case where writing to client.send blocks (client too slow):
//        select {
//        case client.send <- message:
//        default:
//            // client is too slow — unregister and close
//        }
//
// Test disconnects:
//   - Close a browser tab — server should log "client disconnected" cleanly
//   - Kill the server — clients should get a close event in the browser
//
// Key things to notice:
//   - Timeouts + pings are the only reliable way to detect a dead TCP connection
//   - context.Context is Go's standard cancellation mechanism — learn it well
//   - The `default` branch in a channel send is non-blocking — use to drop slow clients

const (
	writeWait  = 10 * time.Second
	pongWait   = 60 * time.Second
	pingPeriod = (pongWait * 9) / 10
	maxMsgSize = 512
)

var upgrader = websocket.Upgrader{
	CheckOrigin: func(r *http.Request) bool { return true },
}

// TODO: copy your Hub and Client from 3.3, then add:
//   - ping/pong handling
//   - write deadlines
//   - context-based shutdown
//   - non-blocking send with slow-client detection

func serveWS(ctx context.Context, hub *Hub, w http.ResponseWriter, r *http.Request) {
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println(err)
		return
	}
	_ = conn
	_ = ctx
	// TODO: create client with context, register, launch pumps
}

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	hub := NewHub()
	go hub.Run()

	http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
		serveWS(ctx, hub, w, r)
	})
	http.HandleFunc("/", serveHome)

	log.Println("Server on :8080")
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
    ws.onopen  = () => log("connected");
    ws.onclose = () => log("disconnected");
    ws.onmessage = e => log("< " + e.data);
    function send() { ws.send(document.getElementById("msg").value); }
    function log(msg) { document.getElementById("log").textContent += msg + "\n"; }
  </script>
</body>
</html>`))
}
