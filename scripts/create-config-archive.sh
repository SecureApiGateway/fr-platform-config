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
file_name="../../sapig-config-overlay-${sapigType}-${realm}-${commit_hash}.tar.gz"
dir="$(cd "../sapig-overlay" && pwd)"
work_dir=`mktemp -d -p "$dir"`

# check if tmp dir was created
if [[ ! "$work_dir" || ! -d "$work_dir" ]]; then
  echo "Could not create working dir for ${sapigType}"
  exit 1
fi

# deletes the temp directory and register the cleanup function to be called on the EXIT signal
function cleanup {      
  #rm -rf "$work_dir"
  echo "Deleted temp working directory $work_dir"
}
trap cleanup EXIT

cp -a $dir/${sapigType}/. $work_dir/
cd $work_dir

# Find any realmName and replace with the ${realm} value within the actual .json files
find . -type f -name '*.json' -exec sed -i "s/realmName/${realm}/g" {} +

# Contains the config without the core-overlay parent dir
# Transforms the realmName placeholder found in paths to the desired realm name e.g. alpha
tar -czf "${file_name}" --transform "s/realmName\(.*\)/${realm}\1/"  $./*

echo "Config archive written to: $(realpath "${file_name}")"