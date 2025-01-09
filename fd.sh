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

CF_RELEASE_VERSION="$(curl -si https://github.com/sharkdp/fd/releases/latest/download/__cufoon_place_holder__ | grep -i '^location:' | head -n 1 | awk -F '/' '{print $(NF -1)}')"
curl -L -o fd.tgz "https://github.com/sharkdp/fd/releases/download/$CF_RELEASE_VERSION/fd-$CF_RELEASE_VERSION-x86_64-unknown-linux-musl.tar.gz"
source ~/.zshrc_cufoon_proxy_off

mkdir fd

tar -xvzf fd.tgz --strip-components=1 -C fd

rm -rf ../fd
mkdir ../fd
cp -r fd/. ../fd
chown -R $CF_USER_NAME:$CF_USER_GROUP ../fd
cd ..
rm -rf ./tmp

