FROM ubuntu:20.04

RUN apt update

RUN DEBIAN_FRONTEND="noninteractive" apt -y install \
        build-essential \
        python3 \
        python3-pip \
        python3-dev \
        automake \
        cmake \
        git \
        clang \
        libtool \
        m4 \
        llvm \
        gcc-9-plugin-dev \
        wget

RUN git clone --depth 1 --branch 4.05c https://github.com/AFLplusplus/AFLplusplus && \
    cd ./AFLplusplus && \
    make install && \
    cd .. && \
    rm -rf ./AFLplusplus

RUN git clone --depth 1 --branch 2.2.2 https://github.com/google/atheris && \
    pip3 install ./atheris/ && \
    rm -rf ./atheris

RUN apt -y install \
    openjdk-11-jdk

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

ENV PATH="/opt/jazzer:$PATH"
RUN mkdir -p /opt/jazzer && cd /opt/jazzer && \
    wget https://github.com/CodeIntelligenceTesting/jazzer/releases/download/v0.13.2/jazzer-linux.tar.gz && \
    tar -xzf jazzer-linux.tar.gz && \
    rm jazzer-linux.tar.gz
