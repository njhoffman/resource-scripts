#!/bin/bash

# find out if system uses SysV init or systemd for process management
ps -p 1

# wheezy uses SysVinit, all services in /etc/init.d
# systemd and upstart all alternatives
# chkconfig --list

service --status-all
service kibana status
ls /etc/init.d
/etc/init.d/{SERVICENAME} start
update-rc.d {SERVICENAME} defaults 95 10

# enable service, S95 is the startup order
cd /etc/rc3.d
ln -s ../iknit.d/{SERVICENAME} S95{SERVICENAME}

# disable service
rm /etc/rc3.d/*{SERVICENAME}

# systemd, used by fedora, adopted by debian
systemctl daemon-reload
systemctl list-unit-files
systemctl start {SERVICENAME}
systemctl stop {SERVICENAME}
systemctl enable {SERVICENAME}
systemctl disable {SERVICENAME}

journalctl -xaf
