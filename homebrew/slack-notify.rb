require 'formula'

class SlackNotify < Formula
  VERSION = '0.1.0'

  homepage 'https://github.com/winebarrel/slack-notify'
  url "https://github.com/winebarrel/slack-notify/releases/download/v#{VERSION}/slack-notify-v#{VERSION}-darwin-amd64.gz"
  sha256 '71a507dc4228c024ca132773c9b8abdac7056cd024dddf67d01cfdb81f8a6056'
  version VERSION
  head 'https://github.com/winebarrel/slack-notify.git', :branch => 'master'

  def install
    system "mv slack-notify-v#{VERSION}-darwin-amd64 slack-notify"
    bin.install 'slack-notify'
  end
end
