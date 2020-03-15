Summary: Provide shared libraries to interface Pascal program with libraw
Name: libpasraw
Version: 1
Release: 1
Group: Sciences/Astronomy
License: GPLv3
URL: http://libpasastro.sourceforge.net
Packager: Patrick Chevalley
BuildRoot: %_topdir/%{name}
BuildArch: x86_64
Provides: libpasraw.so
AutoReqProv: no

%description
Provide shared libraries to interface Pascal program with libraw.
 libpasraw.so    : Interface with libraw to decode camera raw files.

%files
%defattr(-,root,root)
/usr/lib64/libpasraw.so.1.1
/usr/lib64/libpasraw.so.1
/usr/share/doc/libpasraw

%post
/sbin/ldconfig

%postun
/sbin/ldconfig
