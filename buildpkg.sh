#!/bin/bash 

version=1.3.0

builddir=/tmp/libpasraw  # Be sure this is set to a non existent directory, it is removed after the run!

arch=$(arch)

# adjuste here the target you want to crossbuild

unset make_linux32
unset make_linux64
unset make_linuxarm
unset make_linuxaarch64

if [[ $arch == i686 ]]; then 
   make_linux32=1
fi
if [[ $arch == x86_64 ]]; then 
   make_linux64=1
fi
if [[ $arch == armv7l ]]; then 
   make_linuxarm=1
fi
if [[ $arch == aarch64 ]]; then 
   make_linuxaarch64=1
fi


save_PATH=$PATH
wd=`pwd`

# check if new revision since last run
if [[ ! -e last.build ]];  then echo 0 > last.build; fi
read lastrev <last.build
currentrev=$(git rev-list --count --first-parent HEAD)
if [[ -z $currentrev ]]; then currentrev=1; fi
echo $lastrev ' - ' $currentrev
if [[ $lastrev -ne $currentrev ]]; then

# delete old files
  rm libpasraw*.xz
  rm libpasraw*.deb
  rm libpasraw*.rpm
  rm -rf $builddir

# make Linux i386 version
if [[ $make_linux32 ]]; then
  make CPU_TARGET=i386 OS_TARGET=linux clean
  make CPU_TARGET=i386 OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install PREFIX=$builddir
  # tar
  cd $builddir
  cd ..
  tar cvJf libpasraw-$version-$currentrev-linux_i386.tar.xz libpasraw
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasraw*.tar.xz $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/debian $builddir
  cd $builddir
  mkdir debian/libpasraw/usr
  mv lib debian/libpasraw/usr/
  mv share debian/libpasraw/usr/
  cd debian
  sz=$(du -s libpasraw/usr | cut -f1)
  sed -i "s/%size%/$sz/" libpasraw/DEBIAN/control
  sed -i "/Version:/ s/1/$version-$currentrev/" libpasraw/DEBIAN/control
  fakeroot dpkg-deb -Zxz --build libpasraw .
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasraw*.deb $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # rpm
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/rpm $builddir
  cd $builddir
  mkdir -p rpm/libpasraw/usr/
  mv debian/libpasraw/usr/* rpm/libpasraw/usr/
  cd rpm
  sed -i "/Version:/ s/1/$version/"  SPECS/libpasraw.spec
  sed -i "/Release:/ s/1/$currentrev/" SPECS/libpasraw.spec
  setarch i386 fakeroot rpmbuild  --buildroot "$builddir/rpm/libpasraw" --define "_topdir $builddir/rpm/" --define "_binary_payload w7.xzdio" -bb SPECS/libpasraw.spec
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv RPMS/i386/libpasraw*.rpm $wd
  if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $builddir
fi

# make Linux x86_64 version
if [[ $make_linux64 ]]; then
  make CPU_TARGET=x86_64 OS_TARGET=linux clean
  make CPU_TARGET=x86_64 OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install PREFIX=$builddir
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
  cd $builddir
  cd ..
  tar cvJf libpasraw-$version-$currentrev-linux_x86_64.tar.xz libpasraw
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasraw*.tar.xz $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/debian $builddir
  cd $builddir
  mkdir debian/libpasraw64/usr
  mv lib debian/libpasraw64/usr/
  mv share debian/libpasraw64/usr/
  cd debian
  sz=$(du -s libpasraw64/usr | cut -f1)
  sed -i "s/%size%/$sz/" libpasraw64/DEBIAN/control
  sed -i "/Version:/ s/1/$version-$currentrev/" libpasraw64/DEBIAN/control
  fakeroot dpkg-deb -Zxz --build libpasraw64 .
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasraw*.deb $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # rpm
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/rpm $builddir
  cd $builddir
  mkdir -p rpm/libpasraw/usr/
  mv debian/libpasraw64/usr/* rpm/libpasraw/usr/
  # Redhat 64bits lib is lib64
  mv rpm/libpasraw/usr/lib rpm/libpasraw/usr/lib64
  cd rpm
  sed -i "/Version:/ s/1/$version/"  SPECS/libpasraw64.spec
  sed -i "/Release:/ s/1/$currentrev/" SPECS/libpasraw64.spec
# rpm 4.7
  fakeroot rpmbuild  --buildroot "$builddir/rpm/libpasraw" --define "_topdir $builddir/rpm/" --define "_binary_payload w7.xzdio"  -bb SPECS/libpasraw64.spec
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv RPMS/x86_64/libpasraw*.rpm $wd
  if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $builddir
fi

# make Linux arm version
if [[ $make_linuxarm ]]; then
  make CPU_TARGET=armv7l OS_TARGET=linux clean
  make CPU_TARGET=armv7l OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install PREFIX=$builddir
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
  cd $builddir
  cd ..
  tar cvJf libpasraw-$version-$currentrev-linux_armhf.tar.xz libpasraw
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasraw*.tar.xz $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/debian $builddir
  cd $builddir
  mkdir debian/libpasrawarm/usr
  mv lib debian/libpasrawarm/usr/
  mv share debian/libpasrawarm/usr/
  cd debian
  sz=$(du -s libpasrawarm/usr | cut -f1)
  sed -i "s/%size%/$sz/" libpasrawarm/DEBIAN/control
  sed -i "/Version:/ s/1/$version-$currentrev/" libpasrawarm/DEBIAN/control
  fakeroot dpkg-deb -Zxz --build libpasrawarm .
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasraw*.deb $wd
  if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $builddir
fi

# make Linux arm64 version
if [[ $make_linuxaarch64 ]]; then
  make CPU_TARGET=aarch64 OS_TARGET=linux clean
  make CPU_TARGET=aarch64 OS_TARGET=linux
  if [[ $? -ne 0 ]]; then exit 1;fi
  make install PREFIX=$builddir
  if [[ $? -ne 0 ]]; then exit 1;fi
  # tar
  cd $builddir
  cd ..
  tar cvJf libpasraw-$version-$currentrev-linux_arm64.tar.xz libpasraw
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasraw*.tar.xz $wd
  if [[ $? -ne 0 ]]; then exit 1;fi
  # deb
  cd $wd
  rsync -a --exclude=.svn system_integration/Linux/debian $builddir
  cd $builddir
  mkdir debian/libpasrawarm64/usr
  mv lib debian/libpasrawarm64/usr/
  mv share debian/libpasrawarm64/usr/
  cd debian
  sz=$(du -s libpasrawarm64/usr | cut -f1)
  sed -i "s/%size%/$sz/" libpasrawarm64/DEBIAN/control
  sed -i "/Version:/ s/1/$version-$currentrev/" libpasrawarm64/DEBIAN/control
  fakeroot dpkg-deb -Zxz --build libpasrawarm64 .
  if [[ $? -ne 0 ]]; then exit 1;fi
  mv libpasraw*.deb $wd
  if [[ $? -ne 0 ]]; then exit 1;fi

  cd $wd
  rm -rf $builddir
fi

cd $wd

# store revision 
  echo $currentrev > last.build
else
  echo Already build at revision $currentrev
  exit 4
fi

