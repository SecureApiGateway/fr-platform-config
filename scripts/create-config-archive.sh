#!/bin/bash
#
# Helper script which produces a tar.gz containing the config
#
set -e
cd "$(dirname "$0")"
if [ -z "$1" ]; then
  echo "Params missing, ensure SAPIG_TYPE is set"
  exit 1
else
  sapigType=$1
fi

commit_hash=$(git rev-parse --short HEAD)

cd ../sapig-overlay/$sapigType
file_name="../../sapig-config-overlay-${commit_hash}.tar.gz"

# Contains the config without the sapig-overlay parent dir
tar -czf "${file_name}" ./*

echo "Config archive written to: $(realpath "${file_name}")"