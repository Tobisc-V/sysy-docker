#!/bin/bash

# Run ELF

if ! [ $1 ]; then
    echo "please specify ELF file of ${ARCH} to run." > /dev/stderr
    exit 1
fi

ELF=$1

SHELL_FOLDER=$(cd "$(dirname "$0")"; pwd)
source ${SHELL_FOLDER}/sysy-arch-flags.sh

qemu-${ARCH} $ELF
