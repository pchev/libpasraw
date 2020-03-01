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
