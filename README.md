![potmum-sample](https://qiita-image-store.s3.amazonaws.com/0/25728/49020a1e-1e19-2939-e580-216b68f3902b.png)

## 使い方

* https://github.com/settings/applications/new

にアクセスしdocker-compose.ymlの以下を書き換えます。

```
GITHUB_KEY: "XXXXXXXXXXXXXXXXXXXX"
GITHUB_SECRET: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
```

![github](https://qiita-image-store.s3.amazonaws.com/0/25728/d22ea7ba-7945-68bc-e626-e24b03c4ec4a.png)

## 起動

```
mv db/production.sqlite3.empty db/production.sqlite3
```

```
docker-compose up
```

## バックアップ

* db/production.sqlite3 を大切に保管してください。
