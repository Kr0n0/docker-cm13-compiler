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
SSD_MNT=/media/disk
DOCKER_PATH=$HOME/cyanogenmod

# Montamos el disco externo SSD donde están las fuentes localizadas
if [ ! -b "${SSD_EXT}" ]; then
    echo "External disk not available"
    exit -1
fi
if [ ! -d "${SSD_MNT}" ]; then
    mkdir ${SSD_MNT}
fi

echo "Mounting ${SSD_EXT} into ${SSD_MNT}..."
sudo mount ${SSD_EXT} ${SSD_MNT} -o user,exec
sudo chmod 777 ${SSD_MNT}

# Lanzamos la compilación
cd $DOCKER_PATH && sudo ./run.sh && sync

# Desmontamos disco
#sudo umount $SSD_MNT