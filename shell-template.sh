#!/usr/bin/env bash
set -euo pipefail
traditionalIFS="${IFS}"
IFS=$'\n\t'

## TRACE=1 ./script.sh to enable debug mode!
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

## http://redsymbol.net/articles/unofficial-bash-strict-mode/ 
## explains why we need above lines

## If some program needs IFS to be set to traditional value then
## you can just do IFS="${traditionalIFS}" and then run your program.

tmpdir=$(mktemp -d /tmp/tmp.VL.$(basename $0).XXXXXXXXXX)
cleanup() {
  rm -rf "${tmpdir}"
}
trap cleanup EXIT QUIT INT

## Now you can read/write files into this tmpdir and when the script ends it will 
## cleanup the temporary directory. Or you can do pushd...
## pushd ${tmpdir}

exit 0
