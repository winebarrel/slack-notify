require 'formula'

class SlackNotify < Formula
  VERSION = '0.1.0'

  homepage 'https://github.com/winebarrel/slack-notify'
  url "https://github.com/winebarrel/slack-notify/releases/download/v#{VERSION}/slack-notify-v#{VERSION}-darwin-amd64.gz"
  sha256 '...'
  version VERSION
  head 'https://github.com/winebarrel/slack-notify.git', :branch => 'master'

  def install
    system "mv slack-notify-v#{VERSION}-darwin-amd64 slack-notify"
    bin.install 'slack-notify'
  end
end
