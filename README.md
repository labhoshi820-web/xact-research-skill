# xAct Research Skill（Codex-first）

[English](README.en.md) | 日本語

Wolfram Language と xAct を使ったテンソル計算を、Codex が再現可能な形で進めるための Skill です。計算コードだけでなく、仮定、規約、Wolfram のメッセージ、独立検証を分けて扱うワークフローを提供します。公開リポジトリ名は `xact-research-skill`、Skill の呼び出し名は `$xact-research` です。

このリポジトリは Wolfram Research、xAct 開発者、OpenAI の公式プロジェクトではありません。Wolfram Engine、Mathematica、xAct 本体は同梱しません。Codex 用のメタデータと導入例を提供しています。[OpenAI の Skills ドキュメント](https://developers.openai.com/api/docs/guides/tools-skills)が案内する Agent Skills 形式に沿った `SKILL.md`、参照資料、テンプレート、スクリプトは、同様の形式を扱える他の AI coding agent にも調整して利用できます。その互換性は各 agent 側で確認してください。

## できること

| パッケージ | 主な用途 |
| --- | --- |
| xTensor | 抽象添字、計量、共変微分、曲率、テンソル式の標準化 |
| xCoba | 座標、基底、成分配列、具体的な計量の曲率計算 |
| xPert | 計量・曲率テンソルの摂動展開 |
| xTras | テンソル式の整理、作用の変分、Euler 微分 |

同梱テンプレートは、抽象テンソル、作用変分、一次摂動、座標成分計算の最小例です。一般相対論上の仮定、ゲージ、境界条件、曲率符号、物理的解釈を自動的に決めるものではありません。記号計算が終了したことも、物理的結論の正しさを単独では保証しません。

## 必要なもの

- Codex の Skills を利用できる環境
- Wolfram Engine または Mathematica
- xAct
- Bash と GNU `timeout`（macOS では `brew install coreutils` による `gtimeout` も利用可）

Wolfram Engine / Mathematica と xAct は利用者自身の環境へ導入してください。このリポジトリに特定のWolframバージョンやライセンス状態を合わせる必要はありません。導入後に、利用中の環境でスクリプトとテンプレートを検証します。

Windows で同梱シェルスクリプトを使う場合は WSL を推奨します。Wolfram Language のテンプレート自体は、対応する Wolfram 環境で直接実行できます。

## Wolfram Engine の導入

1. [Wolfram Engine](https://www.wolfram.com/engine/) から対象 OS 用を入手します。macOS は Homebrew、Windows は winget、Linux は配布パッケージまたは公式インストーラーも利用できます。
2. Wolfram ID でライセンス条件を確認し、インストール後に `wolframscript` を起動してアクティベーションします。
3. 次を実行し、インストールしたカーネルがコマンドラインから利用できることを確認します。

```bash
./scripts/check-wolfram.sh
```

Free Wolfram Engine の用途、再配布、研究・商用利用には条件があります。公開プロジェクトであっても Engine をこのリポジトリにコピーせず、各利用者が公式サイトから取得し、自分の用途に合うライセンスを確認してください。詳しくは [Wolfram Engine FAQ](https://www.wolfram.com/engine/faq/) を参照してください。

## xAct の導入

1. [xAct の公式ダウンロードページ](https://xact.es/download.html) から一括アーカイブを取得します。
2. 展開して得られる `xAct` ディレクトリを、Wolfram が外部アプリケーション用に検索する `Applications` ディレクトリへ配置します。利用中の環境における配置先は次で確認できます。

```bash
wolframscript -code 'FileNameJoin[{$UserBaseDirectory, "Applications"}]'
```

3. 読み込みを確認します。

```bash
wolframscript -code 'Needs["xAct`xTensor`"]'
```

固定のホームディレクトリを前提にしないでください。公式の [xAct Installation Notes](https://www.xact.es/download/install) も `$UserBaseDirectory` または `$BaseDirectory` を基準にする方法を案内しています。

## Skill のインストール

このリポジトリ自体が1つの Skill フォルダです。Codex の Skills ディレクトリへ次のように clone します。

```bash
git clone https://github.com/labhoshi820-web/xact-research-skill.git "$HOME/.agents/skills/xact-research"
```

その後、新しい Codex セッションで `$xact-research` を指定するか、Wolfram/xAct の解析を依頼します。

例:

```text
$xact-research を使い、4次元の Einstein テンソルのトレースを計算し、規約と検証結果を報告して。
```

Skill は [SKILL.md](SKILL.md) を入口とし、必要に応じて `references/`、`scripts/`、`assets/templates/` を利用します。

## 自分の研究に合わせて育てる

この Skill は、すべての理論・規約・研究環境を網羅した完成品ではなく、安全に始めるための検証済みの土台です。利用者自身の分野や好みに合わせて、たとえば次を調整してください。

- 次元、計量符号、曲率符号、添字名などの標準規約
- 使用する xAct パッケージや研究固有のテンソル定義
- テンプレート、検証項目、計算時間の上限、結果の報告形式
- Codex 以外の AI coding agent 用の配置先やメタデータ

修正後は、代表的な既知の計算と独立した検証を追加し、`$Failed`、`$Aborted`、Wolfram のメッセージ、未評価式を確認してください。研究固有の計算や未公開データは、この公開 Skill へ直接混ぜず、別の作業リポジトリから参照する運用を推奨します。

## ローカル検証

```bash
./scripts/check-wolfram.sh
./scripts/run-wolfram.sh scripts/inspect-xact.wl

for file in assets/templates/*.wl; do
  ./scripts/run-wolfram.sh -t 120 "$file" || exit $?
done
```

Wolfram のメッセージ、`$Failed`、`$Aborted`、未評価式を無視しないでください。xPerm の外部高速化プログラムが利用できない場合など、内部実装へフォールバックして最終チェックが `0` になっても、発生したメッセージと性能上の影響は別に記録してください。

## ディレクトリ構成

```text
xact-research-skill/
├── README.md                日本語版README
├── README.en.md             English README
├── SKILL.md                 Codex が読む主要ワークフロー
├── agents/openai.yaml       Skill の表示メタデータ
├── assets/templates/        最小 Wolfram Language テンプレート
├── references/              xAct の機能別・検証別ガイド
└── scripts/                 環境検出とバッチ実行
```

## 実行ログの取り扱い

環境検査スクリプトは既知のホームディレクトリを `<HOME>` または `<USER_BASE>` に置換します。ただし、Wolfram や xAct 自身が出すメッセージには別のローカルパスが含まれる場合があります。ログやスクリーンショットを共有する前に、認証情報、利用者名、ローカルパス、未公開の研究データがないことを確認してください。
