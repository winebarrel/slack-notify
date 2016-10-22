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
mkdir -p %{buildroot}/usr/sbin
install -m 700 slack-notify %{buildroot}/usr/sbin/

%files
%defattr(700,root,root,-)
/usr/sbin/slack-notify
