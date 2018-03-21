#!/bin/sh

BACKUPLOG="/tmp/backuplog"
SLACKCHANNEL="ml-commenti"

IMDB_DATA_DIR=/tmp/imdb
PRETRAIN_DIR=/tmp/models/imdb_pretrain
TRAIN_DIR=/tmp/models/imdb_classify

export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

cd /tmp/adversarial_text

echo "Launching evaluation" >> ${BACKUPLOG} 2>&1

python3 adversarial_text/evaluate.py \
    --eval_dir=/tmp/models/imdb_eval \
    --checkpoint_dir=/tmp/models/imdb_classify \
    --eval_data=test \
    --run_once \
    --num_examples=25000 \
    --data_dir=/tmp/imdb \
    --vocab_size=87007 \
    --embedding_dims=256 \
    --rnn_cell_size=1024 \
    --batch_size=128 \
    --num_timesteps=400 \
    --normalize_embeddings