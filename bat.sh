#!/bin/zsh
set -e

CF_SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CF_USER_NAME="$(id -un)"
CF_USER_GROUP="$(id -gn)"

cd "$CF_SCRIPT_DIR"
CF_TOKEN="$(cat .github-token)"

if [ -d "../tmp" ]; then
  rm -rf ../tmp
fi
mkdir ../tmp
cd ../tmp

source ~/.zshrc_cufoon_proxy
CF_RELEASE_INFO="$(curl --location 'https://api.github.com/graphql' \
--header 'Content-Type: application/json' \
--header "Authorization: Bearer $CF_TOKEN" \
--data '{"query":"query {\r\n  repository(owner: \"sharkdp\", name: \"bat\") {\r\n    name\r\n    latestRelease {\r\n        name\r\n        releaseAssets(first: 100) {\r\n            nodes {\r\n                downloadUrl\r\n            }\r\n        }\r\n    }\r\n  }\r\n}","variables":{}}')"

echo CF_RELEASE_INFO
echo $CF_RELEASE_INFO

CF_RELEASE_URL="$(echo $CF_RELEASE_INFO | jq -r '.data | .repository | .latestRelease | .releaseAssets | .nodes[] | select(.downloadUrl | contains("x86_64-unknown-linux-musl.tar.gz")) | .downloadUrl')"
echo $CF_RELEASE_URL
curl -L -o bat.tgz $CF_RELEASE_URL
source ~/.zshrc_cufoon_proxy_off

mkdir bat

tar -xvzf bat.tgz --strip-components=1 -C bat

rm -rf ../bat
mkdir ../bat
cp -r bat/. ../bat
chown -R $CF_USER_NAME:$CF_USER_GROUP ../bat
cd ..
rm -rf ./tmp

