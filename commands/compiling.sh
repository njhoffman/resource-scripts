#!/bin/bash

# c/c++ programs
gcc -o hello hello.c
g++ -o hello hello.cpp

# produce debugging information in operating system's native format
gcc -g hello.c

# python
apt-get purge python-requests
apt-get remove python-pip
easy_install -U pip # or
  apt-get install python-requests python-pip # python3-pip
pip install --upgrade pip

# list all available packages, list matched, show details
apt-cache pkgnames
apt-cache search vsftpd
apt-cache show vsftpd
apt-cache pkgnames vsftpd
apt search vim
apt-cache showpkg vsftpd # check dependencies
apt-cache stats # check overall stats
apt-get install -f

# show all installed packages
dpkg --get-selections
dpkg -l readline-common
dpkg -s python3
dpkg --configure -a
apt-show-versions network-manager
ldconfig -v | grep readline



