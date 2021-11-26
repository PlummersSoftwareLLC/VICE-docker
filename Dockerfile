FROM ubuntu:20.04

ENV VICE_VER=3.5
ENV VICE_BASE="vice-${VICE_VER}"
ENV VICE_ARCH="${VICE_BASE}.tar.gz"

WORKDIR /opt

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        wget \
        flex \
        byacc \
        dos2unix \
        xa65 \
        libgl1-mesa-glx \
        libsm6 \
        libxext6 \
        ffmpeg \
        xutils-dev \
        libsdl2-2.0-0 \
        libsdl2-dev \
        libsdl2-image-dev \
        libsdl2-gfx-dev \
        libsdl2-mixer-dev \
        libsdl2-net-dev \
        libsdl2-ttf-dev \
        
        libreadline6-dev \
        libncurses5-dev \        
        libpng-dev \
    && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://sourceforge.net/projects/vice-emu/files/releases/${VICE_ARCH} && \
    tar xvf ${VICE_ARCH} && \
    rm ${VICE_ARCH} && \
    mv ${VICE_BASE} vice

WORKDIR /opt/vice

RUN ./configure --disable-pdf-docs --enable-arch=no && \
    make && \ 
    make install

WORKDIR /

RUN rm -r /opt/vice

ENV DISPLAY=":0.0"
ENV PATH="${PATH}:/usr/local/bin"