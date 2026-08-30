# category-theory-slides

[Typst](https://typst.app/) + [Touying](https://touying-typ.github.io/) で作成するスライド。

## 必要なもの

- [typst](https://github.com/typst/typst)

## スクリプト

### `comp.sh` — スライドのコンパイル

```sh
./comp.sh main
```

`main/main.typ` を`main/main.pdf` にコンパイルする。

### `watch.sh` — スライドのウォッチコンパイル

```sh
./watch.sh main
```

`comp.sh` のウォッチモード版。`main/main.typ` を監視し、変更のたびに
`main/main.pdf` へ自動的に再コンパイルする。

