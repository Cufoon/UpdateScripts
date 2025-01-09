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
# CF_RELEASE_INFO="$(curl --location 'https://api.github.com/graphql' \
# --header 'Content-Type: application/json' \
# --header "Authorization: Bearer $CF_TOKEN" \
# --data '{"query":"query{\r\nrepository(owner:\"sharkdp\",name:\"bat\"){\r\nname\r\nlatestRelease{\r\nname\r\nreleaseAssets(first:100){\r\nnodes{\r\ndownloadUrl\r\n}\r\n}\r\n}\r\n}\r\n}","variables":{}}')"

# echo CF_RELEASE_INFO
# echo $CF_RELEASE_INFO

# CF_RELEASE_URL="$(echo $CF_RELEASE_INFO | jq -r '.data | .repository | .latestRelease | .releaseAssets | .nodes[] | select(.downloadUrl | contains("x86_64-unknown-linux-musl.tar.gz")) | .downloadUrl')"
# echo $CF_RELEASE_URL

CF_RELEASE_VERSION="$(curl -si https://github.com/sharkdp/bat/releases/latest/download/__cufoon_place_holder__ | grep -i '^location:' | head -n 1 | awk -F '/' '{print $(NF -1)}')"
curl -L -o bat.tgz "https://github.com/sharkdp/bat/releases/download/$CF_RELEASE_VERSION/bat-$CF_RELEASE_VERSION-x86_64-unknown-linux-musl.tar.gz"
source ~/.zshrc_cufoon_proxy_off

mkdir bat

tar -xvzf bat.tgz --strip-components=1 -C bat

rm -rf ../bat
mkdir ../bat
cp -r bat/. ../bat
chown -R $CF_USER_NAME:$CF_USER_GROUP ../bat
cd ..
rm -rf ./tmp

