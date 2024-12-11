FROM docker.io/library/python:3.12-slim-bookworm

LABEL \
  maintainer="Liana64" \
  org.opencontainers.image.source="https://github.com/RareCompute/containers"

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL
ARG DEBIAN_FRONTEND=noninteractive

ENV \
  NVIDIA_DRIVER_CAPABILITIES="compute,video,utility,graphics" \
  UMASK="0002" \
  LANG=C.UTF-8 \
  TZ="Etc/UTC" \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONFAULTHANDLER=1 \
  PIP_ROOT_USER_ACTION=ignore \
  PIP_NO_CACHE_DIR=1 \
  PIP_DISABLE_PIP_VERSION_CHECK=1 \
  PIP_BREAK_SYSTEM_PACKAGES=1 \
  UV_HTTP_TIMEOUT=1000

ENV \ 
  USER_NAME=rare \
  UID=1000 \
  GID=1000 \
  SUDO_ACCESS=false \
  LISTEN_PORT=2222 \
  PUBLIC_KEY=""

USER root
WORKDIR /config

COPY ./apps/devserver/root/ /

RUN \
  apt-get update && apt-get install -y --no-install-recommends \
  curl wget unzip catatonit jq lsb-release \
  nano vim tree tmux git htop net-tools sudo strace \
  socat rsync aria2 restic iftop iotop \
  less man fzf ffmpeg ripgrep \
  openssh-server pciutils \
  && mkdir -p /var/run/sshd /config/ssh \
  && chmod 755 /var/run/sshd \
  && printf "UpdateMethod=docker\nBranch=master\nPackageVersion=%s\nPackageAuthor=[RareCompute](https://github.com/RareCompute)\n" "${VERSION}" > /config/package_info \
  && chown -R ${UID}:${GID} /config && chmod -R 755 /config \
  && chmod 755 /entrypoint.sh \
  && chmod 600 /sshd_config.template \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /root/.cache /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && chsh -s /bin/bash

EXPOSE ${LISTEN_PORT}
ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
