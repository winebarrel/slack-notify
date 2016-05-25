package slack_notify

import (
	"flag"
	"log"
	"os"
)

type SlackNotifyParams struct {
	url        string
	channel    string
	username   string
	icon_emoji string
	parse      string
	mrkdwn     bool
}

func ParseFlag() (params *SlackNotifyParams) {
	params = &SlackNotifyParams{}

	flag.StringVar(&params.url, "url", os.Getenv("SLACK_WEBHOOK_URL"), "webhook url")
	flag.StringVar(&params.channel, "c", "", "channel")
	flag.StringVar(&params.username, "u", "", "username")
	flag.StringVar(&params.icon_emoji, "i", "", "icon emoji")
	flag.StringVar(&params.parse, "p", "", "parse")
	flag.BoolVar(&params.mrkdwn, "m", false, "markdown")
	flag.Parse()

	if params.url == "" {
		log.Fatal("'-url' is required")
	}

	return
}
