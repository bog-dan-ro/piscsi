ARG DEBIAN_VERSION=debian:bullseye-slim
FROM ${DEBIAN_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y mc p7zip-full bash-completion zip curl bzip2 git git-lfs \
                   make python3 python3-pip wget cmake ninja-build rsync bison flex libwayland-bin \
                   protobuf-compiler locales locales-all sudo clangd-16 && \
     update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
     update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

ARG USERNAME=pi

RUN useradd -ms /bin/bash ${USERNAME} && \
    passwd -d ${USERNAME} && \
    adduser ${USERNAME} sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${USERNAME}

RUN git lfs install

USER root

ARG TARGET_ARCH=arm64
ARG GCC_COMPILER=g++-aarch64-linux-gnu
RUN  dpkg --add-architecture ${TARGET_ARCH} && \
     apt update && \
     apt install -y ${GCC_COMPILER} \
                    libssl-dev:${TARGET_ARCH} \
                    libcrypt-dev:${TARGET_ARCH} \
                    libspdlog-dev:${TARGET_ARCH} \
                    libpcap-dev:${TARGET_ARCH} \
                    libprotobuf-dev:${TARGET_ARCH} \
                    libgmock-dev:${TARGET_ARCH}

ARG TARGET_TRIPLET=aarch64-linux-gnu-
ENV CROSS_COMPILE ${TARGET_TRIPLET}

USER ${USERNAME}
ENV PKG_CONFIG_PATH /usr/lib/${TARGET_TRIPLET}/pkgconfig

ENV USERNAME=${USERNAME}

WORKDIR /home/pi/piscsi
