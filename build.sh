#!/bin/bash
git config --global user.email "carlos@caseonit.net"
git config --global user.name "Carlos Crisostomo"
git config --global color.ui true
repo --color=always init -u git://github.com/CyanogenMod/android.git -b cm-13.0
repo sync
#cd system/vendor/cm && ./get-prebuilts
source build/envsetup.sh
breakfast bullhead
brunch bullhead