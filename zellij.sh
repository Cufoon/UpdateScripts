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
curl -L -o zellij.tar.gz https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz
source ~/.zshrc_cufoon_proxy_off
tar -xvzf zellij.tar.gz
rm -rf ../zellij
mkdir ../zellij
cp zellij ../zellij
chown -R $CF_USER_NAME:$CF_USER_GROUP ../zellij/zellij
chmod +x ../zellij/zellij
cd ..
rm -rf ./tmp
