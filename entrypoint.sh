#!/bin/bash

# デフォルト値の設定
SERVER_PORT="${SERVER_PORT:-7777}"
RELIABLE_PORT="${RELIABLE_PORT:-8888}"
EXTERNAL_RELIABLE_PORT="${EXTERNAL_RELIABLE_PORT:-8888}"

# ログディレクトリ作成
mkdir -p /home/ubuntu/satisfactory/FactoryGame/Saved/Logs

# サーバー起動
cd /home/ubuntu/satisfactory

/home/ubuntu/satisfactory/FactoryServer.sh \
  -log \
  -Port=${SERVER_PORT} \
  -ReliablePort=${RELIABLE_PORT} \
  -ExternalReliablePort=${EXTERNAL_RELIABLE_PORT}
