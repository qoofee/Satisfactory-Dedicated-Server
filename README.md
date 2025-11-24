# Satisfactory-Dedicated-Server

Satisfactory ゲーム用の Docker ベースの専用マルチプレイヤーサーバーです。Linux 環境で複数のプレイヤーが参加可能なゲームサーバーをホストできます。

## 概要

このプロジェクトは、Satisfactory の専用サーバーを Docker コンテナで実行するためのセットアップを提供します。

**主な特徴:**
- Docker ベースで環境に依存しない統一されたセットアップ
- 環境変数によるサーバー設定のカスタマイズが可能
- ボリュームマウントによるゲーム進捗データの永続化
- マルチプレイヤー対応

## 必要要件

- Docker がインストールされていること
- Docker を実行可能な環境（Linux 推奨）
- 十分なディスク容量（サーバーインストール: 約 10GB、セーブデータ用: 別途必要）

## ビルド方法

リポジトリをクローンし、以下のコマンドで Docker イメージをビルドします：

```bash
git clone https://github.com/qoofee/Satisfactory-Dedicated-Server.git
cd Satisfactory-Dedicated-Server
docker build -t satisfactory-server .
```

ビルドには数分かかります。SteamCMD を使用して Satisfactory Dedicated Server をダウンロード・検証するため、インターネット接続が必要です。

## 起動方法

### 基本的な起動例

```bash
docker run -d \
  -p 7777:7777/udp \
  -p 7777:7777/tcp \
  -p 8888:8888/tcp \
  -v /path/to/ServerConfig:/home/ubuntu/satisfactory/FactoryGame/Saved \
  -v /path/to/savedata:/home/ubuntu/.config/Epic/FactoryGame/Saved \
  satisfactory-server
```

**コマンドの説明:**
- `-d`: バックグラウンドで実行
- `-p 7777:7777/udp`: ゲームサーバー / Beaconポート (UDP)
- `-p 7777:7777/tcp`: クエリポート (TCP)
- `-p 8888:8888/tcp`: Reliableポート (TCP)
- `-v /path/to/ServerConfig:...`: サーバ設定をホストに永続化
- `-v /path/to/savedata:...`: セーブデータをホストに永続化

### 環境変数を指定した起動例

#### SERVER_PORT を 5050 に指定する例

```bash
docker run -d \
  -e SERVER_PORT=5050 \
  -p 5050:5050/udp \
  -p 5050:5050/tcp \
  -p 8888:8888/tcp \
  -v /path/to/ServerConfig:/home/ubuntu/satisfactory/FactoryGame/Saved \
  -v /path/to/savedata:/home/ubuntu/.config/Epic/FactoryGame/Saved \
  satisfactory-server
```

## 環境変数

以下の環境変数でサーバーの動作をカスタマイズできます：

| 環境変数 | デフォルト値 | 説明 |
|---------|----------|------|
| `SERVER_PORT` | 7777 | サーバーが使用するポート番号 |
| `RELIABLE_PORT` | 8888 | Reliableポート番号 |
| `EXTERNAL_RELIABLE_PORT` | 8888 | External Reliableポート番号 |

## ポート・ボリューム設定

### 公開ポート

| ポート | プロトコル | 用途 |
|--------|-----------|------|
| 7777 | UDP | ゲームサーバー / Beaconポート |
| 7777 | TCP | クエリポート |
| 8888 | TCP | Reliableポート |

### ボリュームマウント

#### サーバ設定

サーバ設定は以下のパスに保存されます：

```
コンテナ内: /home/ubuntu/satisfactory/FactoryGame/Saved
ホスト側: /path/to/ServerConfig (任意のパス)
```

ホスト側のパスは、サーバ設定を永続化したい任意のディレクトリに置き換えてください。

#### セーブデータ

セーブデータは以下のパスに保存されます：

```
コンテナ内: /home/ubuntu/.config/Epic/FactoryGame/Saved
ホスト側: /path/to/savedata (任意のパス)
```

ホスト側のパスは、セーブデータを永続化したい任意のディレクトリに置き換えてください。

#### マウント例

```bash
docker run -d \
  -p 7777:7777/udp \
  -p 7777:7777/tcp \
  -p 8888:8888/tcp \
  -v /path/to/ServerConfig:/home/ubuntu/satisfactory/FactoryGame/Saved \
  -v /path/to/savedata:/home/ubuntu/.config/Epic/FactoryGame/Saved \
  satisfactory-server
```

## トラブルシューティング

### サーバーが起動しない場合
- ボリュームマウント先のディレクトリが存在・アクセス可能か確認してください
- `docker logs <container-name>` でコンテナログを確認してください
- サーバーの起動には数分かかる場合があります。ログで進行状況を確認してください

### ポートに接続できない場合

- ファイアウォール設定でポート (7777 UDP/TCP, 8888 TCP) が開いているか確認してください
- ホストマシンからポートが正しく公開されているか確認してください: `docker port <container-name>`
- `SERVER_PORT` を変更した場合、ポート公開時も合わせて変更してください

### コンテナが立ち上がらない場合

- `docker logs <container-name>` でエラーメッセージを確認してください
- ボリュームマウント先のディレクトリのパーミッションを確認してください
- ホストマシンのディスク容量が十分か確認してください（サーバーインストール約10GB + セーブデータ用）

---

**ライセンス:** Satisfactory は Coffee Stain Studios の商標です。
