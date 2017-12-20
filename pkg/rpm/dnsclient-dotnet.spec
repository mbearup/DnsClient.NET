%define      debug_package %{nil}

Name:        PACKAGE
Version:     VERSION
Release:     LABEL
Requires:    dotnet-sdk-2.1.3
Summary:     DNS Client for .NET Framework

Group:       Productivity/Security
License:     Apache Version 2.0
URL:         https://github.com/MichaCo/DnsClient.NET
Source0:     %{name}-%{version}.tgz
BuildRoot:   %{_tmppath}/%{name}-%{version}-%{release}-buildroot

%description
DnsClient.NET is a simple yet very powerful and high performant open source library for the .NET Framework to do DNS lookups

%prep
%setup -q

%build
# Empty section

%install
mkdir -p %{buildroot}/usr
cp -a * %{buildroot}

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
/usr/share/dsts/DnsClient.dll
/usr/share/doc/dnsclient-dotnet/ChangeLog

%changelog

%post
POST-INSTALL
