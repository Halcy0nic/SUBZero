# SUBZero (Secure USB Backup Zero) <br /> 
This is the main repository for the SUBZero, a Raspberry Pi Zero Wireless USB NAS.  Credit for the python https server skeleton code goes to [Rich Moulton](https://github.com/rhmoult/SecurityTools/blob/master/Platform_Independent/Python/httpsWithUpload/src/httpsWithUpload.py). Get the 3D Printed Case [here](https://www.thingiverse.com/thing:3389059)

[![3D Printed Case](https://github.com/Halcy0nic/SUBZero/blob/master/Pictures/SUBZero.jpg)](https://www.thingiverse.com/thing:3389059)

## Features
* Wireless USB Network Access Storage
* Access Point with configurable WPA2 authentication
* Can act as a router for devices connected to the SUBZero wireless network and provide Internet Access
* Easy to use HTTPS File Server
* Built with a $10.00 Raspberry Pi Zero W

### Installation
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

# TODO
1. Write a SUBZero tutorial
2. Add SUBZero specific file changes (dnsmasq.conf, interfaces, hostapd.conf)
