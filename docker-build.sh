#!/bin/bash

ARM_NAME="arm-linux-gnueabihf"
RISCV_NAME="riscv64-linux-gnu"
pkg="gcc-$ARM_NAME gcc-$RISCV_NAME binutils-$ARM_NAME binutils-$RISCV_NAME"
name="ghcr.io/tobisc-v/sysy"
tag="tobisc"

if [ -z "$1" ]; then
    docker build -t "$name:$tag" .
    exit 0
elif [[ "$1" =~ "arm" ]]; then
    pkg="$pkg qemu-user qemu-system-arm"
    tag="arm"
elif [[ "$1" =~ "riscv" ]]; then
    pkg="$pkg qemu-user qemu-system-riscv64"
    tag="riscv"
fi

docker build --build-arg PACKAGES="$pkg" -t "$name:$tag" .
docker push "$name:$tag"
