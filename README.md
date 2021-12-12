

## コンテナの起動
```
docker-compose up -d
```


## コンテナにログイン

```
docker-compose exec tanzuenv bash
```


### コンテナ内に初めて入ったとき

```
tanzu init
```


## 設定ファイルの在り処

- `~/.config/tanzu`
- `~/.cache/tanzu`
- `~/.kube`
- `~/.kube-tkg`
