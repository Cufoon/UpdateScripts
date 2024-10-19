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
curl -L -o fnm.zip https://github.com/Schniz/fnm/releases/latest/download/fnm-linux.zip
unzip fnm.zip
rm -rf ../fnm
mkdir ../fnm
cp fnm ../fnm
chown -R $CFL_USERNAME:$CFL_USERGROUP ../fnm/fnm
chmod +x ../fnm/fnm
cd ..
rm -rf ./tmp
