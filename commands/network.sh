#!/bin/bash

# renew dhcp ip address
dhclient -v -r eth1
dhclient -v eth1
ifdown eth1
ifup eth1
nmcli con
nmcli con down id 'nixcraft_5G'
nmcli con up id 'nixcraft_5G'
/etc/init.d/networking restart

# find external ip
dig +short myip.opendns.com @resolver1.opendns.com

curl -X POST --data "param1=value1&param2=value2" http://localhost
curl -X POST -d @filename.json http://example.com/path/to/resource --header "Content-Type:application/json"

# check if port is open
telnet server.com 1234 # see if port 1234 is open (TCP)
nc -vz -u server.com 1234 # see if port 1234 is open (UDP)

# check if port is open
exec 6<>/dev/tcp/127.0.0.1/11211
echo -e "GET / HTTP/1.0\n" >&6
cat <&6

# list ipv4/6 files
lsof -i

# geoiplookup
apt-get install geoip-bin
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
wget http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz
gunzip GeoIP.dat.gz
gunzip GeoIPASNum.dat.gz
gunzip GeoLiteCity.dat.gz
sudo cp GeoIP.dat GeoIPASNum.dat GeoLiteCity.dat /usr/share/GeoIP
geoiplookup -f /usr/share/GeoIP/GeoLiteCity.dat 23.66.166.151


# test firewalls
nc -u -l -p 9123 # listen on UDP port 9123
nc -u 9123 # send to udp port 9123 on machine "a", start typing

netstat -at   # all tcp connections (-au all udp)
netstat -ltp  # listening tcp connections with PID
netstat -st   # statistics by (tcp) protocol
netstat -ac 5 # promiscuous mode (every 5 seconds)
netstat -r    # kernel ip routing table
netstat -i    # kernel interface transactions
netstat -ie   # kernel interface table
netstat -g    # ipv4/ipv6 information
netstat -c    # print netstat info continuously

tcpdump -D # list interfaces
tcpdump -A -i eth0 # display packets in ASCII format
tcpdump -XX -i eth0 # display packets in hex and ascii format
tcpdump -n -i eth0 # don't resolve names and port numbers
tcpdump -i eth0 port 22 # capture only from port 22
tcpdump -i eth0 src 192.168.0.2 # capture from source
tcpdump -i eth0 dst 45.56.121.208 # capture from destination

ngrep -d eth1 "icanhazip.com"

# get ssl certificate details
# connects to desired website, pipes certificate in PEM format to another openssl command that reads and parses the details
echo | openssl s_client -showcerts -servername b4brands.com -connect b4brands.com:443 | openssl x509 -inform pem -noout -text

# wireless, apt-get install wireless-tools
sudo iwlist scan
nmcli dev wifi


# mtr reports
mtr -rw www.google.com

wget -q -O - http://www.google.com
wget -q -S -O - http://www.google.com
elinks
w3m

#ufw
ufw enable
ufw allow 22
ufw verbose
ufw deny from 15.15.15.51
ufw allow from 15.15.15.0/24 to any port


# iptables
iptables -L
iptables -I INPUT -p tcp -m tcp --dport 3000 -j ACCEPT
*filter

# Allow all loopback (lo0) traffic and reject traffic
# to localhost that does not originate from lo0.
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT ! -i lo -s 127.0.0.0/8 -j REJECT
# Allow ping.
sudo iptables -A INPUT -p icmp -m state --state NEW --icmp-type 8 -j ACCEPT
# Allow SSH connections.
sudo iptables -A INPUT -p tcp --dport 10596 -m state --state NEW -j ACCEPT
# Allow HTTP and HTTPS connections from anywhere
# (the normal ports for web servers).
sudo iptables -A INPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT
# Allow inbound traffic from established connections.
# This includes ICMP error returns.
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# Log what was incoming but denied (optional but useful).
sudo iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables_INPUT_denied: " --log-level 7
# Reject all other inbound.
sudo iptables -A INPUT -j REJECT
# Log any traffic that was sent to you
# for forwarding (optional but useful).
sudo iptables -A FORWARD -m limit --limit 5/min -j LOG --log-prefix "iptables_FORWARD_denied: " --log-level 7
# Reject all traffic forwarding.
sudo iptables -A FORWARD -j REJECT
COMMIT

sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -t mangle -X
sudo iptables -t mangle -F
sudo iptables -t nat -X
sudo iptables -t nat -F
sudo iptables -X
sudo iptables -F

# netcat create server (nc)
netcat -l -p 1234
nc 127.0.0.1 1234
nc -u 127.0.0.1 1234

# troubleshoot network interface
apt-get install ethtool
ethtool eth1
ethtool -S eth1
ethtool -t eth1 online
ethtool -t eth1 offline
ethtool -p eth1 15 # blink nic led for 15 seconds
ethtool -a eth1

netstat -s
nstat
ss -s # socket stats


# linode network debugging
cat /etc/network/interfaces
systemctl status networking.service
ip a
ip r
systemctl status networking.service -l
journalctl -u networking --no-pager | tail -20
# quickly fix firewall issue
mv /etc/network/if-up.d/iptables ~
ifdown -a && ifup -a
