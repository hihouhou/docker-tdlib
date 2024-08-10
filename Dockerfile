#
# TDLib Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

LABEL org.opencontainers.image.authors="hihouhou < hihouhou@hihouhou.com >"

ENV TDLIB_VERSION 0.0.0

# Update & install packages for tdlib
RUN apt-get update && \
    apt-get install -y wget dpkg-dev adduser libfontconfig make git zlib1g-dev libssl-dev gperf cmake g++

#Create tdlib user
RUN adduser --disabled-login --gecos 'tdlib' tdlib

RUN cd && \
  git clone --recursive https://github.com/tdlib/telegram-bot-api.git && \
  cd telegram-bot-api && \
  rm -rf build && \
  mkdir build && \
  cd build && \
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local .. && \
  cmake --build . --target install && \
  cd ../.. && \
  ls -l /usr/local/bin/telegram-bot-api*

USER tdlib

CMD telegram-bot-api --api-id $API_ID --api-hash $API_HASH $OPTIONS
