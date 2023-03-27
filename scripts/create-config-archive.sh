#!/bin/bash
#
# Helper script which produces a tar.gz containing the config
#
set -e
cd "$(dirname "$0")"

commit_hash=$(git rev-parse --short HEAD)

cd ../sapig-overlay/
file_name="../sapig-config-overlay-${commit_hash}.tar.gz"

# Contains the config without the sapig-overlay parent dir
tar -czf "${file_name}" ./*

echo "Config archive written to: $(realpath "${file_name}")"
