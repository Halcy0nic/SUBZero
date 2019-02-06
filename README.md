# SUBZero (Secure USB Backup Zero) <br /> 
This is the main repository for the SUBZero, a Raspberry Pi Zero Wireless USB NAS.  Credit for the python https server skeleton code goes to [Rich Moulton](https://github.com/rhmoult/SecurityTools/blob/master/Platform_Independent/Python/httpsWithUpload/src/httpsWithUpload.py). Get the 3D Printed Case [here](https://www.thingiverse.com/thing:3389059)

[![3D Printed Case](/Pictures/SUBZero5.jpg)](https://www.thingiverse.com/thing:3389059)

## Features
* Wireless USB Network Attached Storage
* Access Point with configurable WPA2 authentication
* Can act as a wireless router for devices connected to the SUBZero wireless network
* Easy to use HTTPS File Server
* Built with a $10.00 Raspberry Pi Zero W

## Installation

#### Flashing the Raspberry Pi Zero W with the SUBZero img

The easiest way to get up and running with the SUBZero is by grabbing /img/SUBZero.img and flashing it onto an SD card.  I recommend using [Ethcher](https://www.balena.io/etcher/) for flashing the SD card.  Etcher is easy to use and works on Windows, OSX, and Linux.

#### Installing from source
To install the SUBZero on your Raspberry Pi Zero W, clone this repository and run the install file.

``` 
$ git clone https://github.com/Halcy0nic/SUBZero.git
$ cd ./SUBZero
$ sudo chmod +x install.sh && sudo ./install.sh
```
During the installation you will be prompted to enter data for the self signed certificate. You can simply enter a '.' or dummy data for all of the fields when generating the cert.  Once you have installed the SUBZero, reboot the machine and you should see a WiFi Access Point named 'SUBZero' that you can connect to with the password 'raspberry'.  Once connected to the SUBZero wireless network you can browse to https://192.168.1.1 and start uploading files .
<br/> <br />NOTE: Your browser might complain about the cert being invalid (because it's self signed).  Proceed to the webpage anyway and add an exception if necessary.

### HTTPS File Server
To run the python server as a standalone HTTPS file server first generate a self signed certificate with openssl:
``` bash
$ openssl req -new -x509 -keyout server.pem -out server.pem -days 365 -nodes
```

This will generate a self signed cert name server.pem, which must be in the same directory as httpsServer.py.  Like before, you can simply enter a '.' for all of the fields when generating the cert to leave them blank. 
Then you can run the python server:

``` bash
$ python httpsServer.py
```
The server will look for the cert (server.pem) and wallpaper (wallpaper.jpg) in the same directory as the httpsServer.py file.  To change the wallpaper, simple rename your custom wallpaper to wallpaper.jpg and place it in this directory.

By default, the SUBZero is not configured to route any traffic or provide internet access.  But configuring the device to route traffic on the network is pretty simple.  First, login to the SUBZero and open /etc/sysctl.conf as sudo on the SUBZero with vim/vi/nano.  Uncomment the line containing 'net.ipv4.ip_forward=1' by remove the # from the beginning of the line, save the changes, and return to to terminal.  Assuming you are using wlan0 for your wifi interface and eth0 for your internet connection, execute the following commands on the terminal:

``` bash
$ sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE  
$ sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT  
$ sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
$ sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
```

Lastly open the file /etc/rc.local as sudo and add the following line at the bottom right before exit 0:

``` bash
iptables-restore < /etc/iptables.ipv4.nat 

### TODO
1. Add Delete option to the HTTPS server
