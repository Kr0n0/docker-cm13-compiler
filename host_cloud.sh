#!/bin/sh -e

# Script de ejecución host.sh para autocompilación en Google Cloud
# 
# v1.0 - Carlos Crisóstomo para Case On IT S.L. - 160511
#
# NOTA : El startup script es 
#       git clone https://github.com/Kr0n0/docker-cyanogenmod.git $HOME/cyanogenmod && $HOME/cyanogenmod/host_cloud.sh
# 

# Variables de entorno

# Almacenamiento
SSD_EXT=/dev/sdb1
DOCKER_PATH=$HOME/cyanogenmod
SSD_EXT_MOUNT_PATH=$DOCKER_PATH/disk

# Creamos estructura de carpetas 
if [ ! -d "${SSD_EXT_MOUNT_PATH}" ]; then
    mkdir ${SSD_EXT_MOUNT_PATH}
fi
if [ ! -d "${DOCKER_PATH}/android" ]; then
    mkdir ${DOCKER_PATH}/android
fi
if [ ! -d "${DOCKER_PATH}/ccache" ]; then
    mkdir ${DOCKER_PATH}/ccache
fi

# Montamos el disco externo SSD donde están las fuentes localizadas
if [ ! -b "${SSD_EXT}" ]; then
    echo "External disk not available"
    exit -1
fi

sudo mount $SSD_EXT $SSD_EXT_MOUNT_PATH -o user,exec
sudo chmod 777 $SSD_EXT_MOUNT_PATH

# Enlazamos las rutas del disco correspondientes para las fuentes y el cache
sudo mount -o bind $SSD_EXT_MOUNT_PATH/android $DOCKER_PATH/android
sudo mount -o bind $SSD_EXT_MOUNT_PATH/ccache $DOCKER_PATH/ccache

# Lanzamos la compilación
cd $DOCKER_PATH && ./run.sh && sync

# Desmontamos disco
sudo umount $DOCKER_PATH/android
sudo umount $DOCKER_PATH/ccache
sudo umount $SSD_EXT_MOUNT_PATH