#!/bin/bash

sudo apt update && sudo apt upgrade
sudo apt -y install hostapd dnsmasq
sudo mkdir -p /var/www/SUBZero/ && sudo cp ./httpsServer.py /var/www/SUBZero && sudo cp wallpaper.jpg /var/www/SUBZero &&  openssl req -new -x509 -keyout server.pem -out server.pem -days 365 -nodes && sudo cp ./server.pem /var/www/SUBZero
 
chmod +x ./subzero.sh && sudo cp ./subzero.sh /usr/local/bin
(sudo crontab -l 2>/dev/null; echo "@reboot /usr/local/bin/subzero.sh") | crontab -

sudo mv /etc/dhcpcd.conf /etc/dhcpcd.bak
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.bak
sudo mv /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.bak
sudo mv /etc/network/interfaces /etc/network/interfaces.bak

sudo cp ./interfaces /etc/network/
sudo cp ./dhcpcd.conf /etc/
sudo cp ./dnsmasq.conf /etc/
sudo cp ./hostapd.conf /etc/hostapd/

sudo systemctl enable hostapd
sudo systemctl enable dnsmasq
