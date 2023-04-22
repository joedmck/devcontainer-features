#!/usr/bin/env bash

# Clean up
rm -rf /var/lib/apt/lists/*

export DEBIAN_FRONTEND=noninteractive

check_packages() {
  echo "Checking for missing packages: $@"
  if ! dpkg -s "$@" > /dev/null 2>&1; then
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
      echo "Running apt-get update..."
      apt-get update -y
    fi
    echo "Installing missing packages..."
    apt-get -y install --no-install-recommends "$@"
  fi
}

check_packages curl ca_certificates 

mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg > /dev/null
source /etc/os-release
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared ${VERSION_CODENAME} main" | tee /etc/apt/sources.list.d/cloudflared.list

apt-get update -y
apt-get -y install --no-install-recommends cloudflared

# Clean up
rm -rf /var/lib/apt/lists/*

echo "Done!"
