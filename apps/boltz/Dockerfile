FROM docker.io/library/python:3.12-slim-bookworm

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  PIP_ROOT_USER_ACTION=ignore \
  PIP_NO_CACHE_DIR=1 \
  PIP_DISABLE_PIP_VERSION_CHECK=1 \
  PIP_BREAK_SYSTEM_PACKAGES=1 \
  CRYPTOGRAPHY_DONT_BUILD_RUST=1\
  #NVIDIA_VISIBLE_DEVICES all \
  NVIDIA_DRIVER_CAPABILITIES="compute,video,utility,graphics"

ENV UMASK="0002" \
  TZ="Etc/UTC"

USER root
WORKDIR /app

RUN \
  apt-get update && apt-get install -y --no-install-recommends \
  curl \
  unzip \
  catatonit \
  build-essential \
  python3-venv \
  && python3 -m venv /opt/venv \
  && . /opt/venv/bin/activate \
  && \
  curl -fsSL -o /tmp/app.zip "https://github.com/jwohlwend/boltz/archive/refs/tags/v${VERSION}.zip" \
  && unzip -q /tmp/app.zip -d /app \
  && \
  printf "UpdateMethod=docker\nBranch=master\nPackageVersion=%s\nPackageAuthor=[RareCompute](https://github.com/RareCompute)\n" "${VERSION}" > /app/package_info \
  && pip install --no-cache-dir \
  torch \
  torchvision \
  torchaudio \
  --requirement /app/requirements.txt \
  && chown -R root:root /app && chmod -R 755 /app \
  && apt-get purge -y build-essential \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /root/.cache /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./apps/boltz/entrypoint.sh /entrypoint.sh

USER nobody:nogroup
WORKDIR /cache
VOLUME ["/cache"]

WORKDIR /predictions
VOLUME ["/predictions"]


ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/jwohlwend/bolt"
