#!/bin/bash

# upgrading distribution
sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
aptitude search '~o' # check for obsolte packages
dpkg -C && apt-mark showhold # verify no errors
sudo rpi-update # optionally upgrade the firmware
# update apt-get sources and verify no output for grep
sudo sed -i 's/jessie/stretch/g' /etc/apt/sources.list
sudo sed -i 's/jessie/stretch/g' /etc/apt/sources.list.d/*.list
grep -lnr jessie /etc/apt
apt list --upgradable # get quick survey of packages to be installed
# speed up steps by removing the list change package
sudo apt-get remove apt-listchanges
# do the upgrade, cleanup and verify
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y && sudo apt-get autoclean
cat /etc/os-release
aptitude search '~o'

# list all available packages, list matched, show details
apt-cache pkgnames
apt-cache search vsftpd
apt-cache show vsftpd
apt-cache pkgnames vsftpd
apt search vim
apt-cache showpkg vsftpd # check dependencies
apt-cache stats # check overall stats
apt-get install -f # --fix-broken

# show all installed packages
dpkg --get-selections
dpkg -l readline-common
dpkg -s python3
dpkg --configure -a
apt-show-versions network-manager
ldconfig -v | grep readline

# get list of held packages, use aptitude instead of apt-get for problematic installations
dpkg --get-selections | grep hold
aptitude install pkgname / aptitude -f install pkgname
aptitude search '~Plibprotobuf' # search provider fields for libprotobuf
# to force update from unsigned repository
apt-get update --allow-unauthenticated
deb [trusted=yes] http://www.example.com stretch main
apt-key adv --keyserver pgp.mit.edu --recv-keys 5C808C2B65558117
sudo apt -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true update

# install specific version
apt-cache policy <pkgname>
apt-get install <pkgname>=<version>

