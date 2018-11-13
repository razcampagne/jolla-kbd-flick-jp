# Japanese Flick Keyboard Support for Sailfish OS

## How to Build

### With Sailfish OS Build Engine

#### Requirements

* [Sailfish OS SDK](https://sailfishos.org/wiki/Application_SDK)

#### Instructions

Please refer to the official [tutorial](https://sailfishos.org/develop/tutorials/building-sailfish-os-packages-manually/) and [wiki](https://sailfishos.org/wiki/Building_packages) for more information on how to build packages.

1. Launch Sailfish OS Build Engine from VirtualBox
2. Connect with ssh (ex. `ssh -p 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/engine/mersdk mersdk@localhost`)
3. Change directory into the repo (ex. `cd share/jolla-kbd-flick-jp .`). `/home/mersdk/share` is a shared directory on the Sailfish OS Build Engine which provides access to the host file system
4. Build the package with `mb2 build`

### With createrpm.sh (Build on Sailfish OS devices themselves)

#### Requirements

* Your Sailfish OS device with developer mode enabled

#### Instructions

1. Launch a Terminal
2. Refresh package information `devel-su pkcon refresh`
3. Install packages which are required for building `devel-su pkcon install rpm-build make qt5-qmake`
4. Clone the repo (ex. `git clone https://github.com/sfos-ja/jolla-kbd-flick-jp.git`)
5. Change directory into the repo (ex. `cd jolla-kbd-flick-jp`)
6. Build the package with `./createrpm.sh`

### After build

Then rpm package will be deployed in `RPMS` directory. 

If you want to install the keyboard on Sailfish OS devices, You can easily transfer the package with scp (ex. `scp RPMS/jolla-kbd-flick-jp-1.0.0-1.noarch.rpm nemo@192.168.2.15:~/Downloads/`). NOTE: to use this command, you need to enable the developer mode on your Sailfish OS phone and connect your phone with a USB cable to your computer and select Developer Mode as the connection mode.
