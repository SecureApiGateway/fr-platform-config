#!/bin/bash
#
# Helper script which produces a tar.gz containing the config
#
set -e
cd "$(dirname "$0")"

# Create config for the alpha realm by default
realm="alpha"
while [[ $# -gt 0 ]]; do
  case $1 in
    --type)
      sapigType="$2"
      shift # past argument
      shift # past value
      ;;
    --realm)
      realm="$2"
      shift # past argument
      shift # past value
      ;;
    *)
      echo "Unknown option - valid options are --type and --realm"
      exit 1
      ;;
  esac
done

if [ -z "${sapigType}" ]; then
  echo "--type must be specified as either ob or core"
  exit 1
fi

commit_hash=$(git rev-parse --short HEAD)

echo "Creating config archive for SAPI-G type: ${sapigType} and FIDC realm: ${realm}"

cd "../sapig-overlay/${sapigType}"
file_name="../../sapig-config-overlay-${sapigType}-${realm}-${commit_hash}.tar.gz"

# Contains the config without the sapig-overlay parent dir
# Transforms the realmName placeholder found in paths to the desired realm name e.g. alpha
tar -czf "${file_name}" --transform "s/realmName\(.*\)/${realm}\1/"  ./*

echo "Config archive written to: $(realpath "${file_name}")"