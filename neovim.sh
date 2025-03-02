#!/bin/zsh
set -e

CF_SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CF_USER_NAME="$(id -un)"
CF_USER_GROUP="$(id -gn)"

cd "$CF_SCRIPT_DIR"
if [ -d "../tmp" ]; then
  rm -rf ../tmp
fi
mkdir ../tmp
cd ../tmp

source ~/.zshrc_cufoon_proxy

CF_FILE_NAME="nvim-linux-x86_64"

curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/$CF_FILE_NAME.tar.gz
source ~/.zshrc_cufoon_proxy_off
tar -xvzf nvim.tar.gz

chown -R $CF_USER_NAME:$CF_USER_GROUP ./$CF_FILE_NAME
if [ -d "../neovim" ]; then
  rm -rf ../neovim
fi
mv ./$CF_FILE_NAME ../neovim
cd ..
rm -rf ./tmp
