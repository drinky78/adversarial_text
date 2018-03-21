#!/bin/sh

BACKUPLOG="/tmp/backuplog"
SLACKCHANNEL="ml-commenti"

IMDB_DATA_DIR=/tmp/imdb
PRETRAIN_DIR=/tmp/models/imdb_pretrain
TRAIN_DIR=/tmp/models/imdb_classify

export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

cd /tmp/adversarial_text

echo "Launching pretrain" >> ${BACKUPLOG} 2>&1
python3 pretrain.py \
    --train_dir=$PRETRAIN_DIR \
    --data_dir=$IMDB_DATA_DIR \
    --vocab_size=87007 \
    --embedding_dims=256 \
    --rnn_cell_size=1024 \
    --num_candidate_samples=1024 \
    --batch_size=128 \
    --learning_rate=0.001 \
    --learning_rate_decay_factor=0.9999 \
    --max_steps=100000 \
    --max_grad_norm=1.0 \
    --num_timesteps=400 \
    --keep_prob_emb=0.5 \
    --normalize_embeddings >> ${BACKUPLOG} 2>&1
