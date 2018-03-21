#!/bin/sh

BACKUPLOG="/tmp/backuplog"
SLACKCHANNEL="ml-commenti"

IMDB_DATA_DIR=/tmp/imdb
PRETRAIN_DIR=/tmp/models/imdb_pretrain
TRAIN_DIR=/tmp/models/imdb_classify

export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

cd /tmp
touch $BACKUPLOG

echo "Starting ML training" > ${BACKUPLOG} 2>&1

echo "Installing base apt packages" >> ${BACKUPLOG} 2>&1
apt-get update && apt-get -y install git wget tar curl
echo "downloading cuda packages" >> ${BACKUPLOG} 2>&1
wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb

echo "depack cuda packages" >> ${BACKUPLOG} 2>&1
sudo dpkg -i cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb

echo "add cuda key" >> ${BACKUPLOG} 2>&1
sudo apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub
sudo apt-get update

echo "installing cuda" >> ${BACKUPLOG} 2>&1
sudo apt-get -y install cuda

echo "cloning repo" >> ${BACKUPLOG} 2>&1
git clone https://github.com/drinky78/adversarial_text.git
