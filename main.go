package main

import (
	"fmt"
	"log"
	"os"
)

func hello(name string) string {
	// Keep the greeting deterministic so the CI unit test can validate it.
	return fmt.Sprintf("Hello %s!", name)
}

func main() {
	if len(os.Args) < 2 {
		log.Fatalln("Missing name: hello <name>")
	}
	fmt.Println(hello(os.Args[1]))
}
