FROM ubuntu:22.04

ENV VICE_VER=3.8
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
        file \
        xa65 \
        xutils-dev \
        libgtk-3-dev \
        libglew-dev \
        libpulse-dev \
        libasound2-dev \
        libpng-dev \
        libcurl4-openssl-dev \
    && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://sourceforge.net/projects/vice-emu/files/releases/${VICE_ARCH} && \
    tar xvf ${VICE_ARCH} && \
    rm ${VICE_ARCH} && \
    mv ${VICE_BASE} vice

WORKDIR /opt/vice

RUN ./configure --disable-pdf-docs && \
    make && \
    make install

WORKDIR /

RUN rm -r /opt/vice

ENV DISPLAY=":0.0"
