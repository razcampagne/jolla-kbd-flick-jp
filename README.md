# Japanese Flick Keyboard Support for Sailfish OS

## Build Introduction

### Requirements

* [Sailfish OS SDK](https://sailfishos.org/wiki/Application_SDK)

### With Sailfish OS Build Engine

Please refer to the official [tutorial](https://sailfishos.org/develop/tutorials/building-sailfish-os-packages-manually/) and [wiki](https://sailfishos.org/wiki/Building_packages) for more information on how to build packages.

1. Launch Sailfish OS Build Engine from VirtualBox
2. Connect with ssh (ex. `ssh -p 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/engine/mersdk mersdk@localhost`)
3. Change directory into the repo (ex. `cd share/jolla-kbd-flick-jp .`). `/home/mersdk/share` is a shared directory on the Sailfish OS Build Engin which provides access to the host file system
4. Build the package with `mb2 build`

Then rpm package will be deployed in `RPMS` directory. 

If you want to install the keyboard on Sailfish OS mobiles, You can easily transfer the package with scp (ex. `scp RPMS/jolla-kbd-flick-jp-1.0.0-1.noarch.rpm nemo@192.168.2.15:~/Downloads/`). NOTE: to use this command, you need to enable the developer mode on your Sailfish OS phone and connect your phone with a USB cable to your computer and select Developer Mode as the connection mode.
