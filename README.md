![potmum-sample](https://qiita-image-store.s3.amazonaws.com/0/25728/49020a1e-1e19-2939-e580-216b68f3902b.png)

## 使い方

```
git clone https://github.com/tukiyo/dockercompose-potmum/ potmum
cd potmum
cp -a db/production.sqlite3.empty db/production.sqlite3
```

* https://github.com/settings/applications/new

![github](https://qiita-image-store.s3.amazonaws.com/0/25728/023fb34c-91fc-cc98-2329-f9363a02467b.png)

docker-compose.ymlの以下を書き換えます。

```
GITHUB_KEY: "XXXXXXXXXXXXXXXXXXXX"
GITHUB_SECRET: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
```

起動

```
docker-compose up -d
```

## バックアップ対象

* ./db/production.sqlite3
* ./attachment_files/

## バージョンアップ方法

```
docker-compose exec potmum bundle exec rake db:migrate
```

* db/production.sqlite3 がmigrateによって更新されます。
