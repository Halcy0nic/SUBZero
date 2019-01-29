# SUBZero (Secure USB Backup Zero) <br /> 
This is the main repository for the SUBZero, a Raspberry Pi Zero Wireless USB NAS.  Credit for the python https server skeleton code goes to [Rich Moulton](https://github.com/rhmoult/SecurityTools/blob/master/Platform_Independent/Python/httpsWithUpload/src/httpsWithUpload.py). Get the 3D Printed Case [here](https://www.thingiverse.com/thing:3389059)

[![3D Printed Case](https://github.com/Halcy0nic/SUBZero/blob/master/imgs/SUBZero.jpg)](https://www.thingiverse.com/thing:3389059)

### HTTPS File Server
To run the python server as a standalone HTTPS file server first generate a self signed certificate with openssl:
``` bash
$ openssl req -new -x509 -keyout server.pem -out server.pem -days 365 -nodes
```

This will generate a self signed cert name server.pem, which must be in the same directory as httpsServer.py.  You can simply enter a '.' for all of the fields when generating the cert to leave them blank. 
Then you can run the python server:

``` bash
$ python httpsServer.py
```
The server will look for the cert (server.pem) and wallpaper (wallpaper.jpg) in the same directory as the httpsServer.py file.  To change the wallpaper, simple rename your custom wallpaper to wallpaper.jpg and place it in this directory.

# TODO
1. Write a SUBZero tutorial
2. Add SUBZero specific file changes (dnsmasq.conf, interfaces, hostapd.conf)
