#!/bin/bash
set -euo pipefail
traditionalIFS="${IFS}"
IFS=$'\n\t'

## http://redsymbol.net/articles/unofficial-bash-strict-mode/ 
## explains why we need above lines

## If some program needs IFS to be set to traditional value then
## you can just do IFS="${traditionalIFS}" and then run your program.

tmpdir=$(mktemp -d tmp.VL.$$.XXXXXXXXXX)
cleanup() {
  rm -rf ${tmpdir}
}
trap cleanup EXIT

## Now you can read/write files into this tmpdir and when the script ends it will 
## cleanup the temporary directory.

