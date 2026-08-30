# biopackathon-claude-skills

[biopackathon2026#8](https://sites.google.com/view/biopackathon/biopackathon20268?authuser=0)
「スクリプトに落とせない反復作業を Claude に覚えさせる 〜 Skills 入門 〜」
に関するサンプルレポジトリ。

## セットアップ

```
uv sync
```

## ドキュメント生成 (sphinx-build)

`src/biopackathon_claude_skills/calc.py` の `docstring` (Google スタイル) から、
`sphinx.ext.napoleon` を使ってドキュメントを生成する。

```
uv run sphinx-build -b html docs docs/_build
```

## プレビュー (sphinx-autobuild)

```
uv run sphinx-autobuild docs docs/_build
```

## スライド

スライドは、`slides/main/.main.pdf`に存在している。

詳細は、[slides/README.md](./slides/README.md)を参照のこと。

