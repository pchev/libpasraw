Summary: Provide shared libraries to interface Pascal program with libraw
Name: libpasraw
Version: 1
Release: 1
Group: Sciences/Astronomy
License: GPLv3
URL: http://libpasastro.sourceforge.net
Packager: Patrick Chevalley
BuildRoot: %_topdir/%{name}
BuildArch: i386
Provides: libpasraw.so
AutoReqProv: no

%description
Provide shared libraries to interface Pascal program with libraw.
 libpasraw.so    : Interface with libraw to decode camera raw files.

%files
%defattr(-,root,root)
/usr/lib/libpasraw.so.1.1
/usr/lib/libpasraw.so.1
/usr/share/doc/libpasraw

%post
/sbin/ldconfig

%postun
/sbin/ldconfig
