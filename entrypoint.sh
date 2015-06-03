#!/bin/sh

set -e

service rsyslog restart

# enable IP forwarding
sysctl -w net.ipv4.ip_forward=1
sysctl -p

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables --table nat --append POSTROUTING --out-interface ppp0 -j MASQUERADE
iptables -I INPUT -s 10.99.99.0/24 -i ppp0 -j ACCEPT
iptables --append FORWARD --in-interface eth0 -j ACCEPT

exec "$@"
