#!/bin/bash
scp -R -P 2222 vagrant@127.0.0.1:/home/vagrant/mydir .

vagrant ssh-config
scp -i IdentityFile -P Port vagrant@127.0.0.1:/file_dir ./
scp -i C:/vagrant/.vagrant/machines/default/virtualbox/private_key -P 2222 vagrant@127.0.0.1:/home/vagrant/artist-pictures/* .

# guest additions
sudo dkms build-essential linux-headers-$(uname -a)
sudo mkdir /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom
sudo sh ./VBoxLinuxAdditions.run --nox11


VBoxManage modifyvm <vm-id> --acpi on | off
VBoxManage list runningvms | vms | ostypes | intnets | hostinfo | systemproperties

# XWindows / X11: use XMing or Cygwin/X
startxwin -- -listen tcp # on windows host in a separate window
export DISPLAY=:0.0
ssh -Y -i C:/HashiCorp/debian/.vagrant/machines/default/virtualbox/private_key -p 2222 vagrant@127.0.0.1
feh myimage.png
feh --list
feh --thumbnails --index-info "%n\n%wx%h"
feh --draw-tinted --info "exifgrep '(Model|DateTimeOriginal|FNumber|ISO|Flash|ExposureTime|FocalLength.\\*)' %F | cut -d . -f 4-"
# xclock

##### linux headless browsing
./node_modules/selenium-standalone/bin/selenium-standalone install
xvfb-run ./node_modules/selenium-standalone/bin/selenium-standalone start

# selenium server (on windows)
/cygdrive/c/ProgramData/Oracle/Java/javapath/java.exe -jar selenium-server-standalone-3.4.0.jar -role hub -port 4444
/cygdrive/c/ProgramData/Oracle/Java/javapath/java.exe -jar selenium-server-standalone-3.4.0.jar -role node -port 5555 -hub http://192.168.1.2:4444/grid/register


