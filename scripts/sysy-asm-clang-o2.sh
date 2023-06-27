#!/bin/bash

# Generate arm assembly .S from .sy or .c

SHELL_FOLDER=$(cd "$(dirname "$0")"; pwd)
CLANG_OPT_FLAGS=-O2 ${SHELL_FOLDER}/sysy-asm-clang.sh $@
