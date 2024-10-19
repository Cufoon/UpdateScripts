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

curl -L -o nvim.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -xvzf nvim.tar.gz
chown -R $CFL_USERNAME:$CFL_USERGROUP ./nvim-linux64
if [ -d "../neovim" ]; then
  rm -rf ../neovim
fi
mv ./nvim-linux64 ../neovim
cd ..
rm -rf ./tmp
