PREFIX=/usr/local
VERSION=`git tag | tail -n 1`
GOOS=`go env GOOS`
GOARCH=`go env GOARCH`

ifdef GOPATH
  RUNTIME_GOPATH=$(GOPATH):`pwd`
else
  RUNTIME_GOPATH=`pwd`
endif

all: slack-notify

slack-notify: main.go src/slack_notify/optparse.go src/slack_notify/slack_notify.go
	GOPATH=$(RUNTIME_GOPATH) go build -o slack-notify main.go

install: slack-notify
	install -m 755 slack-notify $(DESTDIR)$(PREFIX)/bin/

clean:
	rm -f slack-notify *.gz

package: clean slack-notify
	gzip -c slack-notify > slack-notify-$(VERSION)-$(GOOS)-$(GOARCH).gz

deb:
	dpkg-buildpackage -us -uc
