require 'formula'

class SlackNotify < Formula
  VERSION = '0.1.1'

  homepage 'https://github.com/winebarrel/slack-notify'
  url "https://github.com/winebarrel/slack-notify/releases/download/v#{VERSION}/slack-notify-v#{VERSION}-darwin-amd64.gz"
  sha256 '8a61240c891cde8d7cfc9a50044cfe8d55d63fdeb8c15d044d7f76e149d4bece'
  version VERSION
  head 'https://github.com/winebarrel/slack-notify.git', :branch => 'master'

  def install
    system "mv slack-notify-v#{VERSION}-darwin-amd64 slack-notify"
    bin.install 'slack-notify'
  end
end
