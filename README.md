

## コンテナの起動
```
docker-compose up -d
```


## コンテナにログイン

```
docker-compose exec tanzuenv bash
```

### マネジメントクラスタの起動

```
tanzu management-cluster create --ui
```

コンテナを起動しているマシン上でブラウザを起動して、http://127.0.0.1:8080 にアクセスする。


## 設定ファイルの在り処
以下コンテナ終了時に消えないように、ディレクトリをマウントしている。

- `~/.config/tanzu`
- `~/.cache/tanzu`
- `~/.kube`
- `~/.kube-tkg`
