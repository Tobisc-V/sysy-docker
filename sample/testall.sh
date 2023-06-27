#! /bin/bash

function try() {
    eval $@
    if [ $? -ne 0 ]; then
        __ret=$?
        echo "Error $__ret: $@"
        exit $__ret
    fi
}

# gcc arm
try ARCH=arm sysy-elf.sh test.sy
try ARCH=arm sysy-run-elf.sh test.elf
try rm test.elf test.sy.c

# gcc riscv
try ARCH=riscv sysy-elf.sh test.sy
try ARCH=riscv sysy-run-elf.sh test.elf
try rm test.elf test.sy.c

# clang arm
try ARCH=arm sysy-elf-clang.sh test.sy
try ARCH=arm sysy-run-elf.sh test.elf
try rm test.elf test.sy.c

# clang riscv
try ARCH=riscv sysy-elf-clang.sh test.sy
try ARCH=riscv sysy-run-elf.sh test.elf
try rm test.elf test.sy.c

# gcc arm asm
try ARCH=arm sysy-asm-o2.sh test.sy
try rm test.S test.sy.c

# gcc riscv asm
try ARCH=riscv sysy-asm-o2.sh test.sy
try rm test.S test.sy.c

# clang arm
try ARCH=arm sysy-asm-clang-o2.sh test.sy
try rm test.S test.sy.c

# clang riscv
try ARCH=riscv sysy-asm-clang-o2.sh test.sy
try rm test.S test.sy.c

# llvm
try sysy-llvm.sh test.sy
try sysy-run-llvm.sh test.ll
try rm test.ll test.sylib.bc test.sy.c
