# Japanese Flick Keyboard Support for Sailfish OS

## Build Introduction

### Requirements

* [Sailfish OS SDK](https://sailfishos.org/wiki/Application_SDK)

### Step

Please reference official [tutorial](https://sailfishos.org/develop/tutorials/building-sailfish-os-packages-manually/) and [wiki](https://sailfishos.org/wiki/Building_packages)

1. Launch Sailfish OS Build Engine from VirtualBox
2. Connect by ssh (ex. `ssh -p 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/engine/mersdk mersdk@localhost`)
3. Get into the repo (ex. `cd share/jolla-kbd-flick-jp .`). `/home/mersdk/share` is share directory which accessible to host
4. Build the package `mb2 build`

Then rpm package will be deployed in `RPMS` directory. 

If you want to install to Sailfish OS mobiles, You can transfer easily by scp (ex. `scp RPMS/jolla-kbd-flick-jp-0.0.7-1.noarch.rpm nemo@192.168.2.15:~/Downloads/`). However, it requires enable developer mode
