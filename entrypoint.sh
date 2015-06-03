#!/bin/sh

set -e

# enable IP forwarding
sysctl -w net.ipv4.ip_forward=1
sysctl -p

# configure firewall
#control channel
iptables -I INPUT -p tcp --dport 1723 -j ACCEPT
#gre tunnel protocol
iptables -I INPUT  --protocol 47 -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.99.99.0/24 -d 0.0.0.0/0 -o eth0 -j MASQUERADE
#supposedly makes the vpn work better
iptables -I FORWARD -s 10.99.99.0/24 -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j TCPMSS --set-mss 1356

exec "$@"
