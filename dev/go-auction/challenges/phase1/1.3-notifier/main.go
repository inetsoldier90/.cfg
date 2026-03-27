package main

import "fmt"

// Challenge 1.3 — Interface for Notifier
//
// Define a Notifier interface and two implementations.
//
// Steps:
//   1. Define the interface:
//        type Notifier interface {
//            Notify(message string) error
//        }
//   2. Implement ConsoleNotifier — prints the message to stdout
//   3. Implement FileNotifier — writes the message to a file (use os.OpenFile)
//   4. Write a function NotifyAll(notifiers []Notifier, message string) that calls each one
//
// Key things to notice:
//   - Interfaces are satisfied implicitly — no "implements" keyword
//   - Any struct with a Notify(string) error method automatically satisfies Notifier
//   - This is very different from Java's explicit interface declaration

func main() {
	notifiers := []Notifier{
		NewConsoleNotifier(),
		NewFileNotifier("auction_log.txt"),
	}

	NotifyAll(notifiers, "Auction started: Vintage Watch — starting at $100")
	NotifyAll(notifiers, "New bid: $150 by user Alice")
	NotifyAll(notifiers, "Auction closed. Winner: Alice at $150")

	fmt.Println("Done. Check auction_log.txt for file output.")
}

// TODO: define Notifier interface, ConsoleNotifier, FileNotifier, and NotifyAll below
