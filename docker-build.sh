#!/bin/bash

ARM_NAME="arm-linux-gnueabihf"
RISCV_NAME="riscv64-linux-gnu"
pkg="clang llvm lld gcc-$ARM_NAME gcc-$RISCV_NAME binutils-$ARM_NAME binutils-$RISCV_NAME"

if [ -z "$1" ]; then
    docker build -t "sysy:tobisc" .
    exit 0
elif [[ "$1" =~ "arm" ]]; then
    pkg="$pkg qemu-user qemu-system-arm"
elif [[ "$1" =~ "riscv" ]]; then
    pkg="$pkg qemu-user qemu-system-riscv64"
fi

docker build --build-arg PACKAGES="$pkg" -t "sysy:tobisc" .
