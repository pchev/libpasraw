#!/bin/bash

destdir=$PREFIX

if [ -z "$destdir" ]; then
   export destdir=/tmp/libpasraw
fi

echo Install LibPasRaw to $destdir

install -m 755 -d $destdir
install -m 755 -d $destdir/lib
install -m 755 -d $destdir/share
install -m 755 -d $destdir/share/doc
install -m 755 -d $destdir/share/doc/libpasraw

install -v -m 644 -s raw/libpasraw.so.*  $destdir/lib/
install -v -m 644 changelog $destdir/share/doc/libpasraw/changelog
install -v -m 644 copyright $destdir/share/doc/libpasraw/copyright

cd $destdir/lib
ln -s libpasraw.so.1.1 libpasraw.so.1

