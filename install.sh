#!/bin/bash

sudo apt update && sudo apt upgrade
sudo apt install hostapd dnsmasq
sudo mkdir -p /var/www/SUBZero/ && sudo cp ./httpsServer.py /var/www/SUBZero && sudo cp wallpaper.jp /var/www/SUBZero && cd /var/www/SUBZero && openssl req -new -x509 -keyout server.pem -out server.pem -days 365 -nodes
 
chmod +x ./subzero.sh && sudo cp ./subzero.sh /usr/local/bin
(sudo crontab -l 2>/dev/null; echo "@reboot /usr/local/bin/subzero.sh") | crontab -

sudo mv /etc/dhcpcd.conf /etc/dhcpcd.bak
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.bak
sudo mv /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.bak
sudo mv /etc/interfaces /etc/interfaces.bak

sudo cp ./interfaces /etc/
sudo cp ./dhcpcd.conf /etc/
sudo cp ./dnsmasq.conf /etc/
sudo cp ./hostapd /etc/hostapd/
