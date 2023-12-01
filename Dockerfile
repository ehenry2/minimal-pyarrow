FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y -q && \
    apt-get install -y -q --no-install-recommends \
      build-essential \
      cmake \
      libboost-filesystem-dev \
      libboost-regex-dev \
      libboost-system-dev \
      libbrotli-dev \
      libbz2-dev \
      libgflags-dev \
      liblz4-dev \
      libprotobuf-dev \
      libprotoc-dev \
      libre2-dev \
      libsnappy-dev \
      libthrift-dev \
      libutf8proc-dev \
      libzstd-dev \
      pkg-config \
      protobuf-compiler \
      rapidjson-dev \
      zlib1g-dev \
      libcurl4-openssl-dev \
      libssl-dev \
      git \
      python3 \
      python3-pip \
      python3-dev \
      python3-venv && \
    apt-get clean && rm -rf /var/lib/apt/lists* && \
    python3 -m pip install -U setuptools wheel build twine

