#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg > /dev/null
source /etc/os-release
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared ${VERSION_CODENAME} main" | sudo tee /etc/apt/sources.list.d/cloudflared.list

apt-get update -yq
apt-get -yq install --no-install-recommends cloudflared
