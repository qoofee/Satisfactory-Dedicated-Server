FROM steamcmd/steamcmd:latest

# インストール依存関係
RUN apt-get update && apt-get install -y \
  lib32stdc++6 \
  lib32gcc-s1 \
  && rm -rf /var/lib/apt/lists/*

# Satisfactory Dedicated Server のインストール
RUN steamcmd +force_install_dir /home/ubuntu/satisfactory \
  +login anonymous \
  +app_update 1690800 validate \
  +quit

# セーブデータディレクトリのセットアップ
RUN mkdir -p /home/ubuntu/satisfactory/FactoryGame/Saved
RUN mkdir -p /home/ubuntu/.config/Epic/FactoryGame/Saved

# エントリポイントスクリプトをコピー
COPY entrypoint.sh /home/ubuntu/entrypoint.sh
RUN chmod +x /home/ubuntu/entrypoint.sh

# ディレクトリの所有者をubuntuユーザーに変更
RUN chown -R ubuntu:ubuntu /home/ubuntu/satisfactory
RUN chown -R ubuntu:ubuntu /home/ubuntu/.config

# HOME環境変数を明示的に設定
ENV HOME=/home/ubuntu

# ubuntuユーザーで実行
USER ubuntu

# ボリュームマウント対象
VOLUME ["/home/ubuntu/satisfactory/FactoryGame/Saved"]
VOLUME ["/home/ubuntu/.config/Epic/FactoryGame/Saved"]

# ポート公開
EXPOSE 7777/tcp 8888/tcp 7777/udp

WORKDIR /home/ubuntu/satisfactory

ENTRYPOINT ["/home/ubuntu/entrypoint.sh"]
