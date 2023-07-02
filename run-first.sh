#!/usr/bin/bash -eu

# このスクリプトのディレクトリを取得する
SCRIPT_DIR=$(cd $(dirname $0) && pwd)

# 環境変数 LANG からロケールを取得する
LOCALE=$(echo ${LANG} | cut -d "." -f1)

COMMIT_MSG_SUFFIX=
case "${LOCALE}" in
  "en_US" ) COMMIT_MSG_SUFFIX=".en";;
  "ja_JP" ) COMMIT_MSG_SUFFIX=".ja";;
esac

# GitHub からフックを取得しコピーする
if [ -n "$(which curl)" ]; then
  curl -sL \
    "https://raw.githubusercontent.com/to884/git-scripts/main/hooks/prepare-commit-msg${COMMIT_MSG_SUFFIX}" \
    > ${SCRIPT_DIR}/.git/hooks/prepare-commit-msg
    chmod +x ./.git/hooks/prepare-commit-msg
fi