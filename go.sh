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

CF_GO_VERSIONS="$(curl -s 'https://golang.google.cn/dl/?mode=json' --compressed \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:131.0) Gecko/20100101 Firefox/131.0' \
  -H 'Accept: */*' \
  -H 'Accept-Language: zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2' \
  -H 'Accept-Encoding: gzip, deflate, br, zstd' \
  -H 'Referer: https://golang.google.cn/dl/' \
  -H 'Connection: keep-alive' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Priority: u=4' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'TE: trailers')"

CF_GO_FILE="$(echo $CF_GO_VERSIONS | jq -r '.[0] | .files[] | select(.os == "linux" and .arch == "amd64" and .kind == "archive") | .filename')"
echo $CF_GO_FILE
curl -L -o go.tar.gz https://golang.google.cn/dl/$CF_GO_FILE
tar -xvzf go.tar.gz
chown -R $CF_USER_NAME:$CF_USER_GROUP ./go
if [ -d "../go" ]; then
  rm -rf ../go
fi
mv ./go ..
cd ..
rm -rf ./tmp

