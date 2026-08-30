#import "../../globals.typ": *

= Skillsの作り方

== 概要

#slide[
  簡単なPythonスクリプトとdocstringが書かれていて、
  これらの情報を元にSphinxがドキュメントを生成するプロジェクトを例に、
  Skillsの作り方を説明する。

  対象のレポジトリは、以下のURLからクローンできる。

  #link("https://github.com/Myxogastria0808/biopackathon-claude-skills")

  docstringのスタイルは、Google StyleやNumpy Styleなど複数のスタイルが存在する。
  Pythonスクリプトの変更や追加がある度に、docstringの内容を更新•追加する必要がある。
  しかし、docstringのスタイルを統一しつつ、
  丁寧にコメントを記述していくことは非常に大変である。\
  Skillsを作成することにより、docstringの内容をPythonスクリプトに追従させる作業負担を
  大幅に軽減することができる。今回は、このようなSkillsの作り方を例に説明する。
]

== はじめに

#slide[
  これから示すSkillsの作成手順は、あくまで一例であることに留意していただきたい。
  より詳細な情報を知りたい場合は、以下の公式ドキュメントを参照していただきたい。

  - Claude Code Docs: Skills > スキルでClaudeを拡張する

  #link("https://code.claude.com/docs/ja/skills")

  - Claude Code Docs: プラグイン > プラグインを作成する

  #link("https://code.claude.com/docs/ja/plugins")

  - Claude Code Docs: プラグイン > マーケットプレイスから事前構築されたプラグインを発見してインストールする

  #link("https://code.claude.com/docs/ja/discover-plugins")
]

== ① SKILL.mdを作成する

#slide[
  Skillsのエントリポイントは`SKILL.md`というファイルであり、
  このファイルを置いたディレクトリがそのままひとつのSkillsになる。\
  保存する場所によって、誰がそのSkillsを使えるかが変わる。

  - Personal: `~/.claude/skills/<skill-name>/SKILL.md`\
    → 全プロジェクトで利用可能
  - Project: `.claude/skills/<skill-name>/SKILL.md`\
    → そのプロジェクトのみで利用可能\
    　(バージョン管理に含めれば、チームで共有できる)

  また、ディレクトリ名がそのままSkillsの呼び出しコマンド名になる
  (`.claude/skills/update-docstring/` なら `/update-docstring`)。\
  今回はdocstringを追従させる作業をプロジェクトのメンバー全員で共有したいため、
  Projectスキルとして作成する。

  従って、Skillsは以下のように作成すれば良い。

  ```sh
  mkdir -p .claude/skills/update-docstring
  touch .claude/skills/update-docstring/SKILL.md
  ```

  上記の例からもわかる通り、`.claude/skills/<skill-name>/`ディレクトリの下に、`SKILL.md`を作成するだけで、Skillsの作成は完了する。
]

== ② SKILL.mdの内容を記述する

#slide[
  `SKILL.md`は、YAMLフロントマターフィールド (`---`で挟まれた部分) と、
  それに続くMarkdownコンテンツの2つから構成される。

  *YAMLフロントマターフィールド*\
  YAMLフロントマターフィールドには、公式ドキュメントに記載されているフィールどを必要に応じて記述する。
  (公式ドキュメントには、フロントマターリファレンスとして、利用可能なフィールドの一覧が記載されている。)

  *Markdownコンテンツ*\
  Markdownコンテンツには、任意の内容を記述できるが、推奨される書き方が存在する。
]

#slide[
  *YAMLフロントマターフィールド*

  YAMLフロントマターフィールドは、全て任意のフィールドであり、必要に応じて記述する。\
  以下に、いくつか便利なフィールドを紹介する。

  *name*\
  スキルリストに表示される表名。(default: ディレクトリ名)

  *description*\
  スキルの概要と使用タイミングを書くのが望ましい。(default: Mardownコンテンツの最初の段落)
]

#slide[
  *disable-model-invocation*\
  `true`にすると、Claudeが自動でスキルを呼び出さなくなる。その場合、ユーザーが明示的に`/skill-name`で呼び出す必要がある。(default: `false`)

  #figure(
    image("../assets/disable-model-invocation.drawio.png", width: 50%),
    caption: [disable-model-invocation],
  )
]

#slide[
  *user-invocable*\
  `false`にすると、ユーザーが`/skill-name`で呼び出すことができなくなる。(default: `true`)

  #figure(
    image("../assets/user-invocable.drawio.png", width: 45%),
    caption: [user-invocable],
  )
]

#slide[
  *arguments*\
  Skillsには、引数を渡すことができる。ユーザから渡された引数は、`$ARGUMENTS[N]`という形で
  0 ベースのインデックスで特定の引数にアクセス可能である。
  しかし、引数の数が多くなると、どの引数がどのインデックスに対応しているかがわかりにくくなる。
  そのような場合に、`arguments`フィールドを使って、引数の名前を与えることができる。

  *argument-hint*\
  ユーザが使用するSkillsに与えるべき引数がわかるように、引数のヒントを与えることができる。

  `arguments`と`argument-hint`を用いたサンプルとして、`/argument-sample`というSkillsを用意している。

  `/argument-sample`の`SKILL.md`の内容は以下の通りである。

  #text(size: 17pt)[
    ```Markdown
    ---
    name: argument-sample
    description: Demonstrates the skill arguments feature — $ARGUMENTS, $ARGUMENTS[N] / $N, and named arguments declared via the arguments frontmatter field
    disable-model-invocation: true
    argument-hint: [first] [second]
    arguments: [first, second]
    ---

    1. Print "step-1 all arguments (\$ARGUMENTS): $ARGUMENTS"

    2. Print "step-2 first positional argument (\$ARGUMENTS[0] / \$0): $0"

    3. Print "step-3 second positional argument (\$ARGUMENTS[1] / \$1): $1"

    4. Print "step-4 named argument \$first (declared via `arguments: [first, second]` in the frontmatter): $first"

    5. Print "step-5 named argument \$second (declared via `arguments: [first, second]` in the frontmatter): $second"
    ```
  ]
]

#slide[
  `argument-sample`のSkillsを呼び出すと、以下のように引数を渡すことができる。

  #figure(
    image("../assets/argument-sample.png", width: 40%),
    caption: [argument-sample],
  )

  実行結果は以下の通りである。

  #figure(
    image("../assets/argument-sample-result.png", width: 73%),
    caption: [argument-sampleの実行結果],
  )
]

#slide[
  *Markdownコンテンツ*

  Markdownコンテンツには、任意の内容を記述できるが、次のような推奨される書き方が存在する。

  `SKILL.md`自体は簡潔に保ち、500行を超えるような詳細なリファレンスは
  別ファイルに切り出して`SKILL.md`から参照するのが推奨されている。
  Markdown中に、`[reference.md](reference.md)`のように記述することで、
  別ファイルに切り出した詳細なリファレンスの内容と読み込みタイミングをClaudeに
  伝えられる。

  #v(40pt)

  次に、Markdownコンテンツで利用可能なパターンを紹介する。
]

#slide[
  *動的コンテキストの注入*

  インラインフォーム #raw("!`<command>`") 、または、コードブロック #raw("```!<command>```") 構文は、
  Skillsの内容がClaudeに渡される前に、指定されたシェルコマンドを実行し、その出力を構文に対して置き換える
  ことができる。\

  イメージ図\
  #figure(
    image("../assets/dynamic.drawio.png", width: 60%),
    caption: [argument-sampleの実行結果],
  )
]

== ③ 作成したSkillsの挙動を確認する

#slide[
  Skillsが意図通りに働くかは、Claudeが呼び出してくれるかどうかと、
  実行結果が期待通りかどうかを別々に確認する必要がある。\
  確認方法は2通りある。

  - descriptionに合致しそうな頼み方をして、Claudeに自動で呼び出させる\
    例：「lib.pyのdocstringを最新化して」
  - コマンド名で明示的に呼び出す\
    例：`/update-docstring`

  `lib.py`に関数を追加してdocstringを書かない（あるいは古いまま残す）状態を作り、
  上記のいずれかの方法でClaudeに依頼すると、
  `update-docstring`のSkillsが読み込まれ、手順に沿ってdocstringが更新される。
]

