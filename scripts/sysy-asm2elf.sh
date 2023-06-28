#! /bin/bash

if ! [ $1 ]; then
    echo "please specify code file." > /dev/stderr
    exit 1
fi

CODE_FILE=$1

SHELL_FOLDER=$(cd "$(dirname "$0")"; pwd)
source ${SHELL_FOLDER}/sysy-arch-flags.sh

NAME="${CODE_FILE%.*}"
SUFFIX="${CODE_FILE##*.}"

if ! [ $SUFFIX == "S" -o $SUFFIX == "s" -o $SUFFIX == "asm" ]; then
    echo "code file must ends with '.s', '.S', '.asm'" > /dev/stderr
    exit 1
fi

${ARCH_NAME}-gcc ${GCC_ARCH_FLAGS} --static ${SYLIB_INCLUDE_FLAG} -o $NAME.elf $SOURCE ${SYLIB_PATH}/sylib_${ARCH}.a
