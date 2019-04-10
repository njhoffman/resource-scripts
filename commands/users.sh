#!/bin/bash

groupadd developers # add group
useradd -G groupname username # add a new user to secondary group
useradd -g groupname username # add a new user to primary group
usermod -a -G groupname username # add existing user to existing group
usermod -a -g groupname username # change primary group
usermod -aG sudo username # add user to sudoers group
mkhomedir_helpr username # create home directory with /etc/skel content
passwd username # setup password
id username
id | sed -r 's/ |,/\n/g'

# change shell
cat /etc/shells
sudo chsh nhoffman -s /bin/zsh

# add to group
groupadd new-group-name
adduser username group-name

# configure sudoers
export VISUAL=vim; visudo
%server-admins ALL=(ALL) ALL

sudo ZDOTDIR=/home/vagrant/ su postgres -c '/usr/bin/zsh'
sudo ZDOTDIR=/home/vagrant/ su -p -  postgres -c '/usr/bin/zsh'
sudo -u posgres zsh
