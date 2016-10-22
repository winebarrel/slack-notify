%define  debug_package %{nil}

Name:   slack-notify
Version:  0.1.2
Release:  1%{?dist}
Summary:  Notify message to Slack channel.

Group:    Development/Tools
License:  MIT
URL:    https://github.com/winebarrel/slack-notify
Source0:  %{name}.tar.gz
# https://github.com/winebarrel/slack-notify/releases/download/v%{version}/slack-notify_%{version}.tar.gz

%description
Notify message to Slack channel.

%prep
%setup -q -n src

%build
make

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/bin
install -m 755 slack-notify %{buildroot}/usr/bin/

%files
%defattr(755,root,root,-)
/usr/bin/slack-notify
