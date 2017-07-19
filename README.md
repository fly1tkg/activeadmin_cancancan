# README

# 開発環境

Docker環境を準備しています。

利用しない場合は以下の要件が必要です。

- Ruby 2.4.1
- MySQL 5.6

## 開発環境導入

```
docker-compose build
docker-compose run --rm rails rake db:create db:migrate
docker-compose up
```

## 開発中に使うコマンド

`docker-compose build` Rails用の開発環境イメージをビルドします、Gemfileの更新時に操作が必要です。

`docker-compose up` 開発環境を立ち上げます。 http://localhost:3000 でアクセス可能になります。

## コンテナ内で作業したい時に利用するコマンド

`docker-compose run -rm {container_name} {command}` で実行できます。

`docker-compose run --rm rails bash` railsコンテナの中でbashの操作ができるようになります。

DBのマイグレーションなどは `docker-compose run --rm bundle exec rake db:migrate` などを利用すると便利です。

## Macなどで同期が遅い時

Docker for Macはホスト-コンテナ間のファイル共有が遅いようなので、
開発中はdocker-syncを利用することもできるように設定してあります。（Windowsの場合は特に大丈夫だと思います。）

docker-sync動作環境設定

```
gem install docker-sync
brew install fswatch
brew install unison
curl "https://raw.githubusercontent.com/hnsl/unox/master/unox.py" -o "/usr/local/bin/unison-fsmonitor" && chmod +x /usr/local/bin/unison-fsmonitor
sudo easy_install pip && sudo pip install macfsevents
```

`docker-sync-stack start` 開発環境立ち上げ（ `docker-sync start` `docker-compose -f docker-compose.yml -f docker-compose-dev.yml up` 相当）
