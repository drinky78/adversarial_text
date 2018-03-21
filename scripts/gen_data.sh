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

echo "cloning repo" >> ${BACKUPLOG} 2>&1
git clone https://github.com/drinky78/adversarial_text.git
cd adversarial_text

echo "Downloading stanford database" >> ${BACKUPLOG} 2>&1
wget http://ai.stanford.edu/~amaas/data/sentiment/aclImdb_v1.tar.gz \
    -O /tmp/imdb.tar.gz
tar -xf /tmp/imdb.tar.gz -C /tmp
echo "installing tf tf gpu" >> ${BACKUPLOG} 2>&1
pip3 install --upgrade tensorflow
pip3 install --upgrade tensorflow-gpu

echo "Generating vocab" >> ${BACKUPLOG} 2>&1
python3 gen_vocab.py \
    --output_dir=$IMDB_DATA_DIR \
    --dataset=imdb \
    --imdb_input_dir=/tmp/aclImdb \
    --lowercase=False >> ${BACKUPLOG} 2>&1

echo "Generating data" >> ${BACKUPLOG} 2>&1
python3 gen_data.py \
    --output_dir=$IMDB_DATA_DIR \
    --dataset=imdb \
    --imdb_input_dir=/tmp/aclImdb \
    --lowercase=False \
    --label_gain=False >> ${BACKUPLOG} 2>&1