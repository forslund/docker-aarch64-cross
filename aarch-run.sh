#! /usr/bin/env bash

mkdir -p /tmp/script
echo "$@" > /tmp/script/script.sh

docker run -v "/tmp/script/:/script" -v "$PWD:/work" aarch64-cross
