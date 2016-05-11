#!/bin/bash

export PATH=/home/cmbuild/bin:$PATH
export USE_CCACHE=1
export CCACHE_DIR=/srv/ccache
export USER=$(whoami)

cd /home/cmbuild/android

git config --global user.email "carlos@caseonit.net"
git config --global user.name "Carlos Crisostomo"
git config --global color.ui true

repo --color=always init -u git://github.com/CyanogenMod/android.git -b cm-13.0
repo sync
#cd system/vendor/cm && ./get-prebuilts
source build/envsetup.sh
make clobber
breakfast bullhead
brunch bullhead