#!/bin/bash
smbclient -L 192.168.0.6
smbclient --user=Nick -L //192.168.0.6
/usr/bin/smbclient \\\\dionysus\\Nick perseus

smbmount "\\\\dionysus\Nick" -U nicholas -c 'mount /dionysus -u 500 -g 100'

mount -t cifs -o user=Nick //192.168.0.12/G /mnt/G_Movies
mount -o rw,users,uid=1000,dir_mode=0007,file_mode=0777,user=Nick //192.168.0.12/G /mnt/G_Movies
