# libpasraw
Provide shared library to interface Pascal program with libraw

This libraries are used with the following projects:
- ccdciel

Please report any issue at https://www.ap-i.net/mantis/set_project.php?project_id=7

Install version for your Ubuntu system from https://launchpad.net/~pch/+archive/ubuntu/ppa-skychart

### Compilation

You need git, gcc, g++ , make, and libraw-dev

This can be installed with the command:
```
sudo apt install git build-essential libraw-dev
```

Get the source code:
```
git clone https://github.com/pchev/libpasraw.git
cd libpasraw
```

Then compile and install:
```
make clean all
sudo make install PREFIX=/usr
sudo ldconfig
```
### Compilation with a development or new version of Libraw

In some case you want to use the very latest version of Libraw because it support new features or new camera. 

But sometime you cannot install the new version system wide because it break other graphic software from the distribution. This is typically the case with Libraw19 and Libraw20 or the 201910 snapshot.

The solution is to compile the new version of Libraw but not installing it on the system, compile libpasraw with this new version and tell CCDciel to use this other library version. 

This procedure is tested to work with Libraw snapshot 202101.

Install the prerequisite:
```
sudo apt install git build-essential autoconf libtool
```

Create a directory for the software:
```
mkdir ~/source
```

Get and compile Libraw, from git or untar a snapshot:
```
cd ~/source
git clone https://github.com/LibRaw/LibRaw.git
cd LibRaw
autoreconf --install
./configure
make
```

Get and compile libpasraw using the new Libraw in ~/source/LibRaw, please edit Makefile.dev accordingly if you use another path.
```
cd ~/source
git clone https://github.com/pchev/libpasraw.git
cd libpasraw/raw
make -f Makefile.dev
```

Copy the libpasraw library at the same location as Libraw:
```
cp libpasraw.so.1.1 ~/source/LibRaw/lib/.libs
ln -s ~/source/LibRaw/lib/.libs/libpasraw.so.1.1 ~/source/LibRaw/lib/.libs/libpasraw.so.1
```

Run CCDciel using the new library:
```
export LD_LIBRARY_PATH=~/source/LibRaw/lib/.libs
ccdciel
```
You can put this last two command in a shell script to not have to type them every time you want to launch CCDciel.
