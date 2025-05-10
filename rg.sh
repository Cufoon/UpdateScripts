#!/bin/zsh
set -e

CF_SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CF_USER_NAME="$(id -un)"
CF_USER_GROUP="$(id -gn)"

cd "$CF_SCRIPT_DIR"
# CF_TOKEN="$(cat .github-token)"

if [ -d "../tmp" ]; then
  rm -rf ../tmp
fi
mkdir ../tmp
cd ../tmp

source ~/.zshrc_cufoon_proxy

CF_RELEASE_VERSION="$(curl -si https://github.com/BurntSushi/ripgrep/releases/latest/download/__cufoon_place_holder__ | grep -i '^location:' | head -n 1 | awk -F '/' '{print $(NF -1)}')"
curl -L -o ripgrep.tgz "https://github.com/BurntSushi/ripgrep/releases/download/$CF_RELEASE_VERSION/ripgrep-$CF_RELEASE_VERSION-x86_64-unknown-linux-musl.tar.gz"
source ~/.zshrc_cufoon_proxy_off

mkdir ripgrep

tar -xvzf ripgrep.tgz --strip-components=1 -C ripgrep

rm -rf ../ripgrep
mkdir ../ripgrep
cp -r ripgrep/. ../ripgrep
chown -R $CF_USER_NAME:$CF_USER_GROUP ../ripgrep
cd ..
rm -rf ./tmp

