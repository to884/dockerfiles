#-----------------------------------------------------------------------------
# Linuxbrew

FROM ${ACCOUNT}brew-base:latest

ARG USERNAME=ubuntu

USER ${USERNAME}
WORKDIR ${HOME}
COPY --chown=${USERNAME}:${USERNAME} .tmux.conf  .tmux.conf
COPY --chown=${USERNAME}:${USERNAME} powerline .config/powerline
COPY --chown=${USERNAME}:${USERNAME} .gitconfig .gitconfig
COPY --chown=${USERNAME}:${USERNAME} topgrade.toml .config/topgrade.toml
RUN echo $(whoami)
RUN brew install --quiet \
#-----------------------------------------------------------------------------
# python
# インタプリタ型、対話型、オブジェクト指向プログラミング言語
# https://www.python.org/
#-----------------------------------------------------------------------------
      python3 \
#-----------------------------------------------------------------------------
# starship
# クロスシェルプロンプト
# https://starship.rs/
#-----------------------------------------------------------------------------
      starship \
 && mkdir -p ${HOME}/.config \
 && curl -sL \
      https://raw.githubusercontent.com/to884/ansible-playbooks/main/roles/starship/files/starship.toml \
      > .config/starship.toml \
 && echo "export LANG=en_US.UTF-8" >> .bashrc \
 && echo "eval \"\$(starship init bash)\"" >> .bashrc \
#-----------------------------------------------------------------------------
# tmux
# ターミナル・マルチプレクサ（多重化）
# https://github.com/tmux/tmux/wiki 
#-----------------------------------------------------------------------------
 && brew install --quiet \
      tmux \
 && pip3 install --user \
      powerline-status \
      powerline-mem-segment \
 && git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm \
 && sed -i "/^#PLACEHOLDER:POWERLINE/a source \"${HOME}\/.local\/lib\/python$(python3 --version | sed -r 's/Python ([0-9]+\.[0-9]+)\.[0-9]+/\1/')\/site-packages\/powerline\/bindings\/tmux\/powerline.conf\"" ${HOME}/.tmux.conf \
 && echo "export TERM=xterm-256color" >> .bashrc \
 && echo "export LC_ALL=en_US.UTF-8" >> .bashrc \
#-----------------------------------------------------------------------------
# ripgrep
# grep や The Silver Searcher のような検索ツール
# https://github.com/BurntSushi/ripgrep
#-----------------------------------------------------------------------------
 && brew install --quiet \
      ripgrep \
 && echo "alias rg='rg --color=auto'" >> .bashrc \
#-----------------------------------------------------------------------------
# lsd
# カラフルな出力、ファイルタイプのアイコンなどを備えた ls のクローン
# https://github.com/Peltoche/lsd
#-----------------------------------------------------------------------------
 && brew install --quiet \
      lsd \
 && echo "alias ls='lsd --color auto'" >> .bashrc \
 && echo "alias l='lsd -F'" >> .bashrc \
 && echo "alias la='lsd -A'" >> .bashrc \
 && echo "alias ll='lsd -alF'" >> .bashrc \
#-----------------------------------------------------------------------------
# bat
# シンタックスハイライトと Git の統合を備えた cat(1) のクローン
# https://github.com/sharkdp/bat
#-----------------------------------------------------------------------------
 && brew install --quiet \
      bat \
 && echo "alias cat='bat --plain'" >> .bashrc \
 && echo "export BAT_THEME=\"Visual Studio Dark+\"" >> .bashrc \
#-----------------------------------------------------------------------------
# fd
# シンプル、スピーディ、ユーザーフレンドリーな find の代替手段
# https://github.com/sharkdp/fd
#-----------------------------------------------------------------------------
 && brew install --quiet \
      fd \
#-----------------------------------------------------------------------------
# fselect
# SQLライクなクエリでファイルを検索
# https://github.com/jhspetersson/fselect
#-----------------------------------------------------------------------------
 && brew install --quiet \
      fselect \
#-----------------------------------------------------------------------------
# tealdeer
# Rust による tldr の超高速実装
# https://github.com/dbrgn/tealdeer
#-----------------------------------------------------------------------------
 && brew install --quiet \
      tealdeer \
#-----------------------------------------------------------------------------
# delta
# git および diff 出力用のシンタックス・ハイライティング・ページャー
# https://github.com/dandavison/delta
#-----------------------------------------------------------------------------
 && brew install --quiet \
      git-delta \
#-----------------------------------------------------------------------------
# hexyl
# コマンドラインの HEX ビューア
# https://github.com/sharkdp/hexyl
#-----------------------------------------------------------------------------
 && brew install --quiet \
      hexyl \
#-----------------------------------------------------------------------------
# bingrep
# 様々なOSやアーキテクチャのバイナリを検索することができる
# https://github.com/m4b/bingrep
#-----------------------------------------------------------------------------
 && brew install --quiet \
      bingrep \
#-----------------------------------------------------------------------------
# xdelta
# バイナリ差分、差分圧縮ツール
# http://xdelta.org/
# https://github.com/jmacd/xdelta/blob/wiki/CommandLineSyntax.md
#-----------------------------------------------------------------------------
 && brew install --quiet \
      xdelta \
#-----------------------------------------------------------------------------
# tokei
# コードのカウントを素早く行うことができるプログラム
# https://github.com/XAMPPRocky/tokei
#-----------------------------------------------------------------------------
 && brew install --quiet \
      tokei \
#-----------------------------------------------------------------------------
# neofetch
# 高速でカスタマイズ性の高いシステム情報スクリプト
# https://github.com/dylanaraps/neofetch
#-----------------------------------------------------------------------------
 && brew install --quiet \
      neofetch \
#-----------------------------------------------------------------------------
# onefetch
# Git リポジトリの概要をターミナルで確認する
# https://github.com/o2sh/onefetch
#-----------------------------------------------------------------------------
 && brew install --quiet \
      onefetch \
#-----------------------------------------------------------------------------
# git-interactive-rebase-tool
# Git インタラクティブ Rebase のためのネイティブシーケンスエディタ
# https://gitrebasetool.mitmaro.ca/
# https://github.com/MitMaro/git-interactive-rebase-tool
#-----------------------------------------------------------------------------
 && brew install --quiet \
      git-interactive-rebase-tool \
 && git config --global sequence.editor interactive-rebase-tool \
#-----------------------------------------------------------------------------
# fzf
# Go で書かれたコマンドラインのファジーファインダ
# https://github.com/junegunn/fzf
#-----------------------------------------------------------------------------
 && brew install --quiet \
      fzf \
#-----------------------------------------------------------------------------
# dust
# より直感的なduをRustで実現
# https://github.com/bootandy/dust
#-----------------------------------------------------------------------------
 && brew tap tgotwig/linux-dust \
 && brew install --quiet \
      dust \
#-----------------------------------------------------------------------------
# sd
# 直感的な検索と置換が可能な CLI
# https://github.com/chmln/sd
#-----------------------------------------------------------------------------
 && brew install --quiet \
      sd \
#-----------------------------------------------------------------------------
# topgrade
# あらゆるものをアップグレードする
# https://github.com/r-darwish/topgrade
#-----------------------------------------------------------------------------
 && brew install --quiet \
      topgrade \
#-----------------------------------------------------------------------------
# procs
# Rust で書かれた ps のモダンな置き換え
# https://github.com/dalance/procs
#-----------------------------------------------------------------------------
 && brew install --quiet \
      procs \
#-----------------------------------------------------------------------------
# angle-grinder
# コマンドラインでログファイルをスライスして表示する
# https://github.com/rcoh/angle-grinder
#-----------------------------------------------------------------------------
 && brew install --quiet \
      angle-grinder \
#-----------------------------------------------------------------------------
# クリーンアップする
#-----------------------------------------------------------------------------
 && brew cleanup --prune=all
