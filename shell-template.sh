#!/usr/bin/env bash
set -euo pipefail
## traditionalIFS="${IFS}"
IFS=$'\n\t'

## TRACE=1 ./script.sh to enable debug mode!
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

## http://redsymbol.net/articles/unofficial-bash-strict-mode/ 

## If some program needs IFS to be set to traditional value then
## you can just do IFS="${traditionalIFS}" and then run your program.

tmpdir=$(mktemp -d /tmp/tmp.VL."$(basename "$0")".XXXXXXXXXX)
cleanup() {
  rm -rf "${tmpdir}"
}
trap cleanup EXIT QUIT INT
pushd ${tmpdir}



exit 0
