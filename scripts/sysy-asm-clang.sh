#!/bin/bash

# Generate arm assembly .S from .sy or .c

if ! [ $1 ]; then
    echo "please specify code file." > /dev/stderr
    exit 1
fi

SHELL_FOLDER=$(cd "$(dirname "$0")"; pwd)
source ${SHELL_FOLDER}/sysy-arch-flags.sh

CODE_FILE=$1

NAME="${CODE_FILE%.*}"
SUFFIX="${CODE_FILE##*.}"

if [ $SUFFIX == "c" -o $SUFFIX == "sy" ]; then
    SOURCE="${NAME}.sy.c"
    echo '#include "sylib.h"' > $SOURCE
    cat $CODE_FILE >> $SOURCE
else
    echo "code file must ends with '.sy', '.c'" > /dev/stderr
    exit 1
fi

clang ${CLANG_ARCH_FLAGS} ${SYLIB_INCLUDE_FLAG} -S -o $NAME.S $SOURCE ${CLANG_OPT_FLAGS}