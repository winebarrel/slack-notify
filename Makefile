SHELL:=/bin/bash
VERSION=v0.1.2
GOOS=$(shell go env GOOS)
GOARCH=$(shell go env GOARCH)

ifdef GOPATH
  RUNTIME_GOPATH=$(GOPATH):$(shell pwd)
else
  RUNTIME_GOPATH=$(shell pwd)
endif

UBUNTU_IMAGE=docker-go-pkg-build-ubuntu-trusty
UBUNTU_CONTAINER_NAME=docker-go-pkg-build-ubuntu-trusty-$(shell date +%s)
CENTOS_IMAGE=docker-go-pkg-build-centos6
CENTOS_CONTAINER_NAME=docker-go-pkg-build-centos6-$(shell date +%s)

all: slack-notify

slack-notify: main.go src/slack_notify/optparse.go src/slack_notify/slack_notify.go
	GOPATH=$(RUNTIME_GOPATH) go build -a -tags netgo -installsuffix netgo -o slack-notify main.go
ifeq ($(GOOS),linux)
	[[ "`ldd slack-notify`" =~ "not a dynamic executable" ]] || exit 1
endif

clean:
	rm -f slack-notify *.gz

package: clean slack-notify
	gzip -c slack-notify > slack-notify-$(VERSION)-$(GOOS)-$(GOARCH).gz

package\:linux:
	docker run --name $(UBUNTU_CONTAINER_NAME) -v $(shell pwd):/tmp/src $(UBUNTU_IMAGE) make -C /tmp/src package:linux:docker
	docker rm $(UBUNTU_CONTAINER_NAME)

package\:linux\:docker: package
	mv slack-notify-*.gz pkg/

deb:
	docker run --name $(UBUNTU_CONTAINER_NAME) -v $(shell pwd):/tmp/src $(UBUNTU_IMAGE) make -C /tmp/src deb:docker
	docker rm $(UBUNTU_CONTAINER_NAME)

deb\:docker: clean
	dpkg-buildpackage -us -uc
	mv ../slack-notify_* pkg/

docker\:build\:ubuntu-trusty:
	docker build -f docker/Dockerfile.ubuntu-trusty -t $(UBUNTU_IMAGE) .

rpm:
	docker run --name $(CENTOS_CONTAINER_NAME) -v $(shell pwd):/tmp/src $(CENTOS_IMAGE) make -C /tmp/src rpm:docker
	docker rm $(CENTOS_CONTAINER_NAME)

rpm\:docker: clean
	cd ../ && tar zcf slack-notify.tar.gz src
	mv ../slack-notify.tar.gz /root/rpmbuild/SOURCES/
	cp slack-notify.spec /root/rpmbuild/SPECS/
	rpmbuild -ba /root/rpmbuild/SPECS/slack-notify.spec
	mv /root/rpmbuild/RPMS/x86_64/slack-notify-*.rpm pkg/
	mv /root/rpmbuild/SRPMS/slack-notify-*.src.rpm pkg/

docker\:build\:centos6:
	docker build -f docker/Dockerfile.centos6 -t $(CENTOS_IMAGE) .

version:
	@echo $(VERSION)
