#!/bin/bash

# デフォルト値の設定
SERVER_NAME="${SERVER_NAME:-Satisfactory Server}"
SERVER_PORT="${SERVER_PORT:-7777}"
GAME_SPEED="${GAME_SPEED:-1.0}"
MAX_PLAYERS="${MAX_PLAYERS:-4}"
AUTO_SAVE_INTERVAL="${AUTO_SAVE_INTERVAL:-300}"
DIFFICULTY="${DIFFICULTY:-0}"

# ログディレクトリ作成
mkdir -p /home/ubuntu/satisfactory/FactoryGame/Saved/Logs

# サーバー起動
cd /home/ubuntu/satisfactory

/home/ubuntu/satisfactory/FactoryServer.sh \
  -log \
  -Port=${SERVER_PORT} \
  -ServerName="${SERVER_NAME}" \
  -GameSpeed=${GAME_SPEED} \
  -MaxPlayers=${MAX_PLAYERS} \
  -AutoSaveInterval=${AUTO_SAVE_INTERVAL}
