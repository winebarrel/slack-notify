package slack_notify

import (
	"encoding/json"
	"net/http"
	"strings"
)

type Payload struct {
	Channel    string `json:"channel,omitempty"`
	Username   string `json:"username,omitempty"`
	Icon_emoji string `json:"icon_emoji,omitempty"`
	Text       string `json:"text"`
	Parse      string `json:"parse,omitempty"`
	Mrkdwn     bool   `json:"mrkdwn"`
}

func post(params *SlackNotifyParams, payload string) (err error) {
	var req *http.Request
	req, err = http.NewRequest(
		"POST",
		params.url,
		strings.NewReader(payload),
	)

	if err != nil {
		return
	}

	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}

	var resp *http.Response
	resp, err = client.Do(req)

	if err != nil {
		return
	}

	defer resp.Body.Close()

	return
}

func build_payload(params *SlackNotifyParams, message string) (payload_json string, err error) {
	payload := Payload{Text: message}

	if params.channel != "" {
		payload.Channel = params.channel
	}

	if params.username != "" {
		payload.Username = params.username
	}

	if params.icon_emoji != "" {
		payload.Icon_emoji = params.icon_emoji
	}

	if params.parse != "" {
		payload.Parse = params.parse
	}

	payload.Mrkdwn = params.mrkdwn

	var bs []byte
	bs, err = json.Marshal(payload)

	if err != nil {
		return
	}

	payload_json = string(bs)
	return
}

func Notify(params *SlackNotifyParams, message string) (err error) {
	var payload string
	payload, err = build_payload(params, message)

	if err != nil {
		return
	}

	err = post(params, payload)

	return
}
