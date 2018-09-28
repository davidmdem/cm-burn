#!/bin/bash

CM_BIN = "~/.cloudmesh/bin"

#
# Make sure that a directory exists for executable dependencies.
#

# Default to Mac
ETCHER_DOWNLOAD_URL = "https://github.com/resin-io/etcher/releases/download/v1.4.4/etcher-cli-1.4.4-darwin-x64.tar.gz"

# Detect OS
# Source: https://stackoverflow.com/a/8597411/120783
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Detect 32/64 bit
    # Source: https://stackoverflow.com/a/106416/120783
    MACHINE_TYPE=`uname -m`
    if [ ${MACHINE_TYPE} == 'x86_64' ]; then
        ETCHER_DOWNLOAD_URL = "https://github.com/resin-io/etcher/releases/download/v1.4.4/etcher-cli-1.4.4-linux-x64.tar.gz"
    else
        ETCHER_DOWNLOAD_URL = "https://github.com/resin-io/etcher/releases/download/v1.4.4/etcher-cli-1.4.4-linux-x86.tar.gz"
    fi
else
    # Unknown.
    exit 1
fi

