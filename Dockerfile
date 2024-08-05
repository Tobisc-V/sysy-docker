FROM ubuntu:22.04
ENV ARM=arm
ENV ARM_NAME="arm-linux-gnueabihf"
ENV RISCV=riscv64
ENV RISCV_NAME="riscv64-linux-gnu"
ENV GCC_ARM_FLAGS="-march=armv7-a -mfloat-abi=hard -mfpu=neon-vfpv4 -mthumb"
ENV GCC_RISCV_FLAGS="-march=rv64gc -mabi=lp64d"
ENV CLANG_ARM_FLAGS="--target=${ARM_NAME} --sysroot=/usr/${ARM_NAME} -m32"
ENV CLANG_RISCV_FLAGS="--target=${RISCV_NAME} --sysroot=/usr/${RISCV_NAME} -m64"
ENV CLANG_ARM_LINK_FLAGS="-fuse-ld=lld -static"
ENV CLANG_RISCV_LINK_FLAGS="-static"
# Install necessary software

ENV PACKAGES_0="clang llvm lld qemu-user"
ARG PACKAGES=" \
    gcc-${ARM_NAME} binutils-${ARM_NAME} qemu-system-${ARM} \
    gcc-${RISCV_NAME} binutils-${RISCV_NAME} qemu-system-${RISCV}"

# RUN sed -i "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y tzdata
RUN apt-get install -y ${PACKAGES_0}
RUN apt-get install -y ${PACKAGES}
# Load sysy library
ENV SYLIB_PATH=/usr/share/sylib
ENV SYLIB_INCLUDE_FLAG="-I${SYLIB_PATH}"
COPY sylib/* ${SYLIB_PATH}/
RUN clang -emit-llvm -S ${SYLIB_PATH}/sylib.c -o ${SYLIB_PATH}/sylib.ll
RUN clang ${CLANG_ARM_FLAGS} -c ${SYLIB_PATH}/sylib.c -o ${SYLIB_PATH}/sylib_arm.o && \
    llvm-ar rcs ${SYLIB_PATH}/sylib_arm.a ${SYLIB_PATH}/sylib_arm.o
RUN clang ${CLANG_RISCV_FLAGS} -c ${SYLIB_PATH}/sylib.c -o ${SYLIB_PATH}/sylib_riscv64.o && \
    llvm-ar rcs ${SYLIB_PATH}/sylib_riscv64.a ${SYLIB_PATH}/sylib_riscv64.o
RUN rm ${SYLIB_PATH}/sylib_arm.o ${SYLIB_PATH}/sylib_riscv64.o
# Load sysy scripts
COPY scripts/sysy* /usr/bin/
RUN chmod +x /usr/bin/sysy*.sh

WORKDIR /root
# Copy Sample
COPY sample/* /root/
RUN chmod +x /root/*.sh
