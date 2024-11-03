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
curl -L -o eza.tar.gz https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-musl.tar.gz
source ~/.zshrc_cufoon_proxy_off
tar -xvzf eza.tar.gz
rm -rf ../eza
mkdir ../eza
cp eza ../eza
chown -R $CF_USER_NAME:$CF_USER_GROUP ../eza/eza
chmod +x ../eza/eza
cd ..
rm -rf ./tmp
