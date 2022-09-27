# このリポジトリについて

このリポジトリは主に開発用途に使用する環境を Docker イメージとしてビルドします。
Ubuntu をベースに、[Linuxbrew](https://docs.brew.sh/Homebrew-on-Linux) をパッケージマネージャーとして使用し、開発に使用するツール等をインストールします。

## Docker イメージについて

各ディレクトリに Dockerfile が存在し、それぞれの Docker イメージの用途は次のようになります。

| ディレクトリ | 用途 |
| :------------ | :------------------ |
| `brew-base` | 開発用ユーザーの作成と `linuxbrwe` のインストールおよび設定を行います。 |
| `cli-enhanced` | [`tmux`](https://github.com/tmux/tmux/wiki)、[`starship`](https://starship.rs/) や、Linux の基本コマンド（`ls`、`grep`、`find`、`sed` 等）の代替ツールをインストールし CLI 環境を強化します。それぞれのツールは基本コマンドより高機能であり、ほとんどが Rust で実装されています。 |

詳細については、各ディレクトリにある `Dockerfile` を参照してください。

## Docker イメージをビルドするには

Docker イメージをビルドする場合は、このリポジトリのルートにある `image-build` スクリプトを使用します。

`image-build` スクリプトの引数は、Dockerfile の存在するディレクトリと開発環境で使用するユーザー名です。たとえば次のように使用します。

```bash
$ ./image-build cli-enhanced user01
```

ユーザーについては省略可能であり、省略した場合はホスト側 OS の現在の実行ユーザーの名前が使用されます。

また、DockerHub などの Docker レジストリのアカウント名を追加できます。その場合は次のようになります。

```bash
$ ./image-build アカウント名/cli-enhanced user01
```

現状でのそれぞれのディレクトリに対する `image-build` の引数は次のとおりです。

| ディレクトリ | 引数 | 例 |
| :--------------- | :---------------- | :--------- |
| `brew-base`  | "タグ（`account/tag` もしくは `tag` の形式" "作成ユーザー名(省略可。省略した場合は現在のユーザー)" | `image-build brew-base --user p1234567` |
| `cli-enhanced` | "タグ（`account/tag` もしくは `tag` の形式" "作成ユーザー名(省略可。省略した場合は現在のユーザー)" | `image-build cli-enhanced --user p1234567` |

## Docker コンテナを開発環境として使用するには

Docker コンテナを使用する場合は、このリポジトリのルートにある `container-login` スクリプトを使用します。

`container-login` スクリプトの引数は、Docker イメージタグと作業用ディレクトリとしてバインドするホスト側のディレクトリです。たとえば次のように使用します。

```bash
./container-login cli-enhanced --cred-dir ~/Credentials --work-dir ~/Documents
```

スクリプトを実行すると、Docker コンテナはホスト側のディレクトリ `~/Documents` をコンテナの `${HOME}/Documents` にバインドし、コンテナに Docker イメージをビルドする際に作成したユーザーでログインします。

> コンテナで `tmux` を使用する場合、ホスト OS で `tmux` を実行しているとコンテナの `tmux` は意図したとおりに実行できません。
>
> コンテナで `tmux` を使用する場合は、ホスト OS 端末で `tmux` を使用しないようにしてください。

現状でのそれぞれのディレクトリに対する `container-login` の引数は、`container-login ディレクトリ名 --help` で参照できます。

## パスワードなどのクレデンシャルをイメージに記憶させたくない場合は

プロキシのユーザー名、パスワードやトークンなどのようなクレデンシャルは、コンテナがバインドしたホスト側ディレクトリにクレデンシャルを配置して、コンテナ起動時にそれを読み込むようにします。

たとえば `cli-enhanced` では、コンテナ起動時の `.bashrc` に `source /var/credentials/.secrets` が記述されており、バインドしたホスト側のディレクトリの `.secrets` を読み込むように設定してあります。

## Docker コンテナの状態を保存するには

Docker コンテナは原則的に永続的なデータを保持しません。永続的なデータを扱う場合は、ホスト側のディレクトとバインドしたディレクトリに保存します。

例外的にコンテナの状態を保存したい場合（たとえばコアダンプを保持したいなど）は、ホスト OS で`docker commit` コマンドで該当するコンテナをイメージとして保存します。`docker commit` は次のように使用します。

```bash
$ docker commit <保存したいコンテナIDあるいはコンテナ名> <保存するイメージ名>
```

これでコンテナを終了させてもコンテナの状態をイメージに保存しているので、次回は `docker commit` で作成したイメージ ID を引数に `docker run` を実行することで、コンテナの状態を再開することができます。
