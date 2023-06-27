
if [ ${ARCH}_ = "arm_" ]; then
    ARCH_NAME=${ARM_NAME}
    CLANG_ARCH_FLAGS=${CLANG_ARM_FLAGS}
    CLANG_LINK_FLAGS=${CLANG_ARM_LINK_FLAGS}
    GCC_ARCH_FLAGS=${GCC_ARM_FLAGS}
elif [ ${ARCH}_ = "riscv_" -o ${ARCH}_ = "riscv64_" ]; then
    ARCH_NAME=${RISCV_NAME}
    CLANG_ARCH_FLAGS=${CLANG_RISCV_FLAGS}
    CLANG_LINK_FLAGS=${CLANG_RISCV_LINK_FLAGS}
    GCC_ARCH_FLAGS=${GCC_RISCV_FLAGS}
    ARCH=riscv64
else
    echo "please specify target arch: arm or riscv" > /dev/stderr
    exit 1
fi
