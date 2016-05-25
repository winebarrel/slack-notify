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

### OS X

```sh
brew install https://raw.githubusercontent.com/winebarrel/slack-notify/master/homebrew/slack-notify.rb
```

### Ubuntu

```sh
wget -q -O- https://github.com/winebarrel/slack-notify/releases/download/v0.1.0/slack-notify_0.1.0_amd64.deb | dpkg -i -
```
