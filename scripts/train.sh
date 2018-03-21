#!/bin/sh

BACKUPLOG="/tmp/backuplog"
SLACKCHANNEL="ml-commenti"

IMDB_DATA_DIR=/tmp/imdb
PRETRAIN_DIR=/tmp/models/imdb_pretrain
TRAIN_DIR=/tmp/models/imdb_classify

export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

cd /tmp/adversarial_text

echo "Launching train classifier" >> ${BACKUPLOG} 2>&1
python3 train_classifier.py \
    --train_dir=$TRAIN_DIR \
    --pretrained_model_dir=$PRETRAIN_DIR \
    --data_dir=$IMDB_DATA_DIR \
    --vocab_size=87007 \
    --embedding_dims=256 \
    --rnn_cell_size=1024 \
    --cl_num_layers=1 \
    --cl_hidden_size=30 \
    --batch_size=64 \
    --learning_rate=0.0005 \
    --learning_rate_decay_factor=0.9998 \
    --max_steps=15000 \
    --max_grad_norm=1.0 \
    --num_timesteps=400 \
    --keep_prob_emb=0.5 \
    --normalize_embeddings \
    --adv_training_method=vat \
    --perturb_norm_length=5.0 >> ${BACKUPLOG} 2>&1

escapedText=$(echo $BACKUPLOG | sed 's/"/\"/g' | sed "s/'/\'/g" )

json="{\"channel\": \"#$SLACKCHANNEL\", \"text\": \"$escapedText\"}"

curl -s -d "payload=$json" "https://hooks.slack.com/services/T024HM08C/B03DB521U
/4IMDz3zzNdb0C3002p1S1er0"