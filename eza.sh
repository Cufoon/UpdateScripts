#!/bin/zsh
set -e

CFL_SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CFL_USERNAME="$(id -un)"
CFL_USERGROUP="$(id -gn)"

cd "$CFL_SCRIPT_DIR"
if [ -d "../tmp" ]; then
  rm -rf ../tmp
fi
mkdir ../tmp
cd ../tmp
curl -L -o eza.tar.gz https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-musl.tar.gz
tar -xvzf eza.tar.gz
rm -rf ../eza
mkdir ../eza
cp eza ../eza
chown -R $CFL_USERNAME:$CFL_USERGROUP ../eza/eza
chmod +x ../eza/eza
cd ..
rm -rf ./tmp
