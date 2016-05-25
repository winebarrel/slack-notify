package main

import (
	"bufio"
	"io/ioutil"
	"log"
	"os"
	"slack_notify"
	"strings"
)

func init() {
	log.SetFlags(0)
}

func scan() string {
	reader := bufio.NewReader(os.Stdin)
	input, _ := ioutil.ReadAll(reader)
	return strings.TrimRight(string(input), "\n")
}

func main() {
	defer func() {
		if err := recover(); err != nil {
			log.Fatal(err)
		}
	}()

	params := slack_notify.ParseFlag()
	message := scan()
	err := slack_notify.Notify(params, message)

	if err != nil {
		log.Fatal(err)
	}
}
