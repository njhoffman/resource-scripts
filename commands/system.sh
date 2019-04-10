#!/bin/bash

# system information
cat /proc/cpuinfo # devices, diskstats, modules, meminfo, stat, swaps, uptime, version, vmstat, zoneinfo
lscpu
hardinfo
lshw

# distribution/release
cat /etc/*-release
lsb_release -a
uname -a
uname -mrs
cat /proc/version

# upgrade bash
wget http://ftp.gnu.org/gnu/bash/bash-4.4.tar.gz
tar xf bash-4.4.tar.gz
cd bash-4.4 && ./configure && make && sudo make install

# display system messages
dmesg -w -e

# calibrate system time
ntpdate pool.ntp.org

# show currently loaded shared objects
vimcat /proc/PID/maps
sudo grep libcairo.so /proc/*/maps
lsof /path/to/lib.so

# add PPA and authentication key
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:fontforge/fontforge
# TODO: describe sources.d, keyrings, etc

# building from source
LIBS=-lposix ./configure
make
make install
make clean # removes libraries and object files from build directory
make distclean # removes files created by ./configure script (to compile on different computer)

# change hostname
hostnamectl
sudo hostnamectl set-hostname host.example.com
# edit /etc/hosts and replace hostname


apt-key list
apt-key add <file> # - for stdin

# increase sudo timeout: sudo visudo => Defaults: env_reset, timestamp_timeout=1440


# working with soundcards
modinfo soundcore
sudo lspci -v | grep -A7 -i audio
alsamixer -c1
aplay -L # list all PCMs
aplay -l # list all devices
amixer -c2 sset 'IEC958 In' on
Simple mixer control 'IEC958 In',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


speaker-test -Dhw:2,1 -c2

C-Media CMI8786

sudo apt-get purge \
  cairo-dock-impulse-plug-in \
  gstreamer1.0-pulseaudio \
  libcanberra-pulse \
  libpulse-dev \
  libpulse-java \
  libpulse-jni \
  libpulse-mainloop-glib0 \
  libpulse-ocaml \
  libpulse-ocaml-dev \
  libpulse0 \
  libpulsedsp \
  libsox-fmt-pulse \
  liquidsoap-plugin-pulseaudio \
  mkchromecast-pulseaudio \
  osspd-pulseaudio \
  projectm-pulseaudio \
  pulseaudio \
  pulseaudio-dlna \
  pulseaudio-equalizer \
  pulseaudio-esound-compat \
  pulseaudio-module-bluetooth \
  pulseaudio-module-gconf \
  pulseaudio-module-jack \
  pulseaudio-module-lirc \
  pulseaudio-module-raop \
  pulseaudio-module-zeroconf \
  pulseaudio-utils \
  pulsemixer \
  pulseview \
  snd-gtk-pulse \
  xfce4-pulseaudio-plugin \
  xmms2-plugin-pulse \
  xrdp-pulseaudio-installer
