# SUBZero (Secure USB Backup Zero) <br /> 
This is the main repository for the SUBZero, a Raspberry Pi Zero Wireless USB NAS.  Credit for the python https server skeleton code goes to [Rich Moulton](https://github.com/rhmoult/SecurityTools/blob/master/Platform_Independent/Python/httpsWithUpload/src/httpsWithUpload.py). Get the 3D Printed Case [here](https://www.thingiverse.com/thing:3389059)

[![3D Printed Case](/Pictures/SUBZero5.jpg)](https://www.thingiverse.com/thing:3389059)

## Features
* Wireless Network Access Storage
* Access Point with configurable WPA2 authentication
* Full TCP/IP on the local SUBZero network
* Can act as a wireless router for devices connected to the SUBZero network, but can also be used *completely offline*
* IP Masquerading
* Removable/Replaceable SD card.  This allows you to buy either a large or small SD card depending on your own needs.
* Easy to use HTTPS File Server
* Built with a $10.00 Raspberry Pi Zero W running Raspbian Stretch Lite. This fares better than a traditional USB in some cases because the SUBZero is also a fully functional computer.
* Can be run/powered by your phone using a USB to USB-C/Lightning/Micro-USB/etc adapter

## What You Need
* Raspberry Pi Zero W
* Micro SD card
* Pi Zero USB Stem (Optional)
* Soldering Station (Optional)
* 3D Printer (Optional)

## Installation

#### Flashing the Raspberry Pi Zero W with the SUBZero Image

The easiest way to get up and running with the SUBZero is by grabbing [SUBZero.img](https://github.com/Halcy0nic/SUBZero/blob/master/img/SUBZero.img) and flashing it onto an SD card.  I recommend using [Ethcher](https://www.balena.io/etcher/) for flashing the SD card.  Etcher is easy to use and works on Windows, OSX, and Linux.

#### Installing from source
To install the SUBZero on your Raspberry Pi Zero W, clone the SUBZero repository from my [GitHub](https://github.com/Halcy0nic/SUBZero) and run the install script.

``` 
$ git clone https://github.com/Halcy0nic/SUBZero.git
$ cd ./SUBZero
$ sudo chmod +x install.sh && sudo ./install.sh
```
During the installation, you will be prompted to enter data for the self-signed certificate. You can simply enter a '.' or dummy data for all of the fields when generating the cert.  Once you have installed the SUBZero, reboot the machine and you should see a WiFi Access Point named 'SUBZero' that you can connect to with the password 'raspberry'.  Once connected to the SUBZero wireless network you can browse to https://192.168.1.1 and start uploading files.
<br/> <br />NOTE: Your browser might complain about the cert being invalid (because it's self-signed).  Proceed to the webpage anyway and add an exception if necessary.

## PI Zero USB Stem

According to [Zerostem](https://zerostem.io), the Pi 'Zero Stem is a PCB shim that turns a Raspberry Pi Zero into a USB dongle. Once the shim is installed, your Raspberry Pi can be plugged directly into a computer or USB hub without any additional cables or power supplies.'  This is much more convenient than using a USB adapter, which would normally be required for a Pi Zero.  Installing the Zero Stem requires some soldering experience.  Once you have a Pi and Zero Stem you can turn it into a USB by soldering the STEM onto the Pi Zero using their [instructions](https://zerostem.io/installation/).

## 3D printed case
Lots of thanks go to Nick Engmann for this one.  He developed the case for the [3D printed Pi Zero Case](https://www.thingiverse.com/thing:3389059).  He actively contributes to the SUBZero project and has some amazing projects of his own on his [website](https://nickengmann.com), so go check him out!


## Routing
By default, the SUBZero is not configured to route any traffic or provide internet access.  But configuring the device to route traffic on the network is pretty simple.  I found a [tutorial](https://frillip.com/using-your-raspberry-pi-3-as-a-wifi-access-point-with-hostapd/) by Phil Martin showing how to do this.  First, log in to the SUBZero and open /etc/sysctl.conf as sudo on the SUBZero with vim/vi/nano.  Uncomment the line containing 'net.ipv4.ip_forward=1' by removing the # from the beginning of the line, save the changes, and return to the terminal.  Assuming you are using wlan0 for your wifi interface and eth0 for your internet connection, execute the following commands on the terminal:

``` bash
$ sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE  
$ sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT  
$ sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
$ sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
```

Lastly open the file /etc/rc.local as sudo and add the following line at the bottom right before exit 0:

``` bash
iptables-restore < /etc/iptables.ipv4.nat 
```

### TODO
1. Add Delete option to the HTTPS server



