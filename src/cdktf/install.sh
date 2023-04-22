#!/usr/bin/env bash

echoerr() { printf "\033[0;31m%s\n\033[0m" "$*" >&2; }

install_via_npm() {
    PACKAGE=$1
    
    echo "Checking if node and npm are installed..."
    if ! type npm >/dev/null 2>&1; then
       echoerr "Node and/or NPM are not installed."
       exit 1
    fi
    echo "Installing npm package: $PACKAGE"
    npm install -g --omit=dev $PACKAGE
}

install_via_npm cdktf-cli@$VERSION

echo "Done!"
