#!/bin/sh

# enable IP forwarding
sysctl -w net.ipv4.ip_forward=1
sysctl -p

echo "localip 10.99.99.1" >> /etc/pptpd.conf
echo "remoteip 10.99.99.100-199" >> /etc/pptpd.conf
echo "debug" >> /etc/pptpd.conf
echo "tian pptpd 299792458 *" >> /etc/ppp/chap-secrets
echo "ms-dns 8.8.8.8" >> /etc/ppp/pptpd-options
echo "ms-dns 8.8.4.4" >> /etc/ppp/pptpd-options
echo "debug" >> /etc/ppp/pptpd-options
echo "dump" >> /etc/ppp/pptpd-options

iptables -A INPUT -p tcp --dport 1723 -j ACCEPT
iptables -A INPUT -p gre -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.99.99.0/24 -o eth0 -j MASQUERADE
iptables -A FORWARD -p tcp --syn -s  10.99.99.0/24 -j TCPMSS --set-mss 1356


pptpd --fg
