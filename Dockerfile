FROM ubuntu:18.04

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

# Install aarch64 gcc and build tools
RUN apt-get update -y
RUN apt-get install -y gcc-aarch64-linux-gnu bison build-essential python device-tree-compiler bc flex swig python-dev flex bc bison kmod cpio libssl-dev fakeroot rsync
WORKDIR "/work"
ENTRYPOINT ["/bin/bash", "/script/script.sh"]
