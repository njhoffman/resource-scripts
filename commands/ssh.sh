#!/bin/bash

# generate keys for passwordless login (all from client machine)
ssh-keygen -R 198.51.100.4 # revoke key for IP address when rebuilding server
ssh-keygen -b 4096
ssh-keygen -t rsa
ssh nhoffman@server mkdir -p .ssh
cat ~/.ssh/id_rsa.pub | ssh nhoffman@server 'cat >> .ssh/authorized_keys'
ssh nhoffman@server "chmod 700 .ssh; chmod 640 .ssh/authorized_keys"
ssh user@host <<'ENDSSH'
  --commands to run on local host--
ENDSSH

# 1) copies local_src to remote_dst, 2) executes command, 3) cpies remote_src to local_dst
ssh user@host "cat > remote_dst; command; cat remote_src" < local_src > local_dst

#!/bin/bash
HELLO="world"
ssh -t $HOST bash -c "'
  if true; then
      echo $HELLO
  fi
  echo "Hello world"
  sudo ls /root
'"

# scp
scp -R -P 2222 vagrant@127.0.0.1:/home/vagrant/mydir .
scp -i IdentityFile -P Port vagrant@127.0.0.1:/file_dir ./
scp -i C:/vagrant/.vagrant/machines/default/virtualbox/private_key -P 2222 vagrant@127.0.0.1:/home/vagrant/artist-pictures/* .
ssh vagrant@127.0.0.1 -p2222 -i C:/HashiCorp/debian/.vagrant/machines/default/virtualbox/private_key -o 'StrictHostKeyChecking no'
# https://github.com/hashicorp/vagrant/issues/9143

# ssh tunneling
# forward client port 6378 to host localhost 6379 at example.com
ssh -L 6378:localhost:6379 ec2-user@example.com
# -N keeps SSH running without a promopt, & puts it in background
ssh -N -L 8080:ww.xx.yy.zz:80 user@server &
# supress all messages from tunnel
ssh -N -L 8080:ww.xx.yy.zz:80 user@server >/dev/null 2>&1 &
ssh -f -N -L 8080:ww.xx.yy.zz:80 user@server

# autoclose after 10 seconds (Of inactive port fowards)
ssh -f -o ExitOnForwardFailure=yes -L 3306:localhost:3006 abc@example.com sleep 10
mysql -e 'SHOW DATABASES;' -h 127.0.0.1

# autoclose using ssh control sockets
ssh -M -S my-ctrl-socket -fN -L 5000:localhost:3306  abc@example.com
ssh -S myctrl-socket -O exit abc@example.com

# debug server sshd
$(which sshd) -Ddp 10222

# prevent sshd closing connection
mkdir -p /home/$USER/.ssh
echo "Host *\nServerAliveInterval 240" > /home/$USER/.ssh/config
chmod 600 /home/$USER/.ssh/config

# TODO: ssh agent instructions
