#!/bin/sh -e
repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0
repo sync
cd system/vendor/cm && ./get-prebuilts
source build/envsetup.sh
breakfast bullhead
brunch bullhead
