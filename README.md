# slack-notify

Notify message to Slack channel.

## Usage

```
Usage of slack-notify:
  -c string
      channel
  -i string
      icon emoji
  -u string
      username
  -url string
      webhook url
```

```sh
export SLACK_WEBHOOK_URL="https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXXXXXXXXXXXXXXXXX"
cat hello | slack-notify -i :ghost: -u scott
```

## Installation

```
brew install https://raw.githubusercontent.com/winebarrel/slack-notify/master/homebrew/slack-notify.rb
```
