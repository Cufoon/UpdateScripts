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
curl -L -o fnm.zip https://github.com/Schniz/fnm/releases/latest/download/fnm-linux.zip
source ~/.zshrc_cufoon_proxy_off
unzip fnm.zip
rm -rf ../fnm
mkdir ../fnm
cp fnm ../fnm
chown -R $CF_USER_NAME:$CF_USER_GROUP ../fnm/fnm
chmod +x ../fnm/fnm
cd ..
rm -rf ./tmp
