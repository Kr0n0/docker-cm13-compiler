docker-cm13-compiler
==================

Create a fully automated [Docker] based environment to build [CyanogenMod] under Google Cloud Platform (an any other Cloud Provider).
Made as a fork from the original docker-cyanogenmod from [stucki] for compiling Nexus 5X CM13.

This Dockerfile will create a docker container which is based on Ubuntu 14.04.
It will install the "repo" utility and any other build dependencies which are required to compile CyanogenMod.

The main working directory is a shared folder on the host system, so the Docker container can be removed at any time.

**NOTE:** Remember that CyanogenMod is a huge project. It will consume a large amount of disk space (~80 GB) and it can easily take hours to build.

### Cloud requisites

* **RAM** : 16GB RAM
* **CPUs** : 4 vCPU
* **DISK** : 
    * 10GB (Host) - /dev/sda
    * 100GB (External - EXT4 with 2 directories : android and ccache already created)  - /dev/sdb1
* **STARTUP SCRIPT** : git clone GITHUB_CLONE_URL $HOME/cyanogenmod && $HOME/cyanogenmod/host_cloud.sh


### How to run/build

**NOTES:**
* You will need to [install Docker][Docker_Installation] to proceed!
* If an image does not exist, ```docker build``` is executed first

```
git clone https://github.com/stucki/docker-cyanogenmod.git
cd docker-cyanogenmod
./run.sh
```

The `run.sh` script accepts the following switches:

* -u|--enable-usb - runs the container in privileged mode (this way you can use adb right from the container)
* -r|--rebuild - force rebuild the image from scratch

The container uses "screen" to run the shell. This means that you will be able to open additional shells using [screen keyboard shortcuts][Screen_Shortcuts].

### How to build CyanogenMod for your device

```
repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0
repo sync
source build/envsetup.sh
breakfast <device codename>   # example: breakfast grouper
brunch <device codename>      # example: brunch grouper
```

### Links

For further information, check the following links:

* [Original docker-cyanogenmod][stucki]
* [CyanogenMod Building Basics][Cyanogenmod_Building_Basics]
* [Learning to Build CyanogenMod][Learning_to_Build_CM]
* [Build Instructions for Google Nexus 5][CyanogenMod_Build_Nexus5] (example device, search the wiki for other devices)

### More information

* [Discussion thread @ XDA developers]

==================

[Docker]:                      https://www.docker.io/
[CyanogenMod]:                 http://www.cyanogenmod.org/
[Docker_Installation]:         https://www.docker.io/gettingstarted/
[Screen_Shortcuts]:            http://www.pixelbeat.org/lkdb/screen.html
[CyanogenMod_Building_Basics]: http://wiki.cyanogenmod.org/w/Doc:_Building_Basics
[Learning_to_Build_CM]:        http://wiki.cyanogenmod.org/w/Development#Learning_To_Build_CM
[CyanogenMod_Build_Nexus5]:    http://wiki.cyanogenmod.org/w/Build_for_hammerhead
[Discussion thread @ XDA developers]: http://forum.xda-developers.com/showthread.php?t=2650345
[dotcloud/docker#2224]:        https://github.com/dotcloud/docker/issues/2224
[stucki]:   https://github.com/stucki/docker-cyanogenmod
