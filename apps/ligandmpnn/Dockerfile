FROM docker.io/library/python:3.11-slim-bookworm

LABEL \
  maintainer="Liana64" \
  org.opencontainers.image.source="https://github.com/dauparas/LigandMPNN"

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL
ARG DEBIAN_FRONTEND=noninteractive

ENV \
  NVIDIA_DRIVER_CAPABILITIES="compute,video,utility,graphics" \
  PATH="/opt/venv/bin:$PATH" \
  UMASK="0002" \
  LANG=C.UTF-8 \
  TZ="Etc/UTC" \
  USERNAME=rare \
  UID=900 \
  GID=900 \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONFAULTHANDLER=1 \
  PIP_ROOT_USER_ACTION=ignore \
  PIP_NO_CACHE_DIR=1 \
  PIP_DISABLE_PIP_VERSION_CHECK=1 \
  PIP_BREAK_SYSTEM_PACKAGES=1 \
  UV_HTTP_TIMEOUT=1000

USER root
WORKDIR /app

RUN \
  groupadd --gid ${GID} ${USERNAME} \
  && useradd --uid ${UID} --gid ${GID} --create-home --shell /bin/bash ${USERNAME} \
  && apt-get update && apt-get install -y --no-install-recommends \
  curl unzip build-essential catatonit jq \
  gnupg ca-certificates lsb-release \
  nano vim tree git wget \
  && git clone https://github.com/dauparas/LigandMPNN /tmp/app \
  && cp -R /tmp/app/* /app \
  && printf "UpdateMethod=docker\nBranch=master\nPackageVersion=%s\nPackageAuthor=[RareCompute](https://github.com/RareCompute)\n" "${VERSION}" > /app/package_info \
  && chown -R ${UID}:${GID} /app && chmod -R 755 /app \
  && curl -LsSf https://astral.sh/uv/0.5.6/install.sh | sh \
  && . $HOME/.local/bin/env \
  && uv venv --no-python-downloads /opt/venv \
  && . /opt/venv/bin/activate \
  && cd /tmp/app \
  && uv pip install -r /tmp/app/requirements.txt \
  && chown -R ${UID}:${GID} /opt/venv && chmod -R 755 /opt/venv \
  && apt-get purge -y build-essential \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /root/.cache /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && chsh -s /bin/bash

COPY --chown=${UID}:${GID} ./apps/ligandmpnn/entrypoint.sh /entrypoint.sh
RUN chmod -R 755 /entrypoint.sh

USER ${USERNAME}

WORKDIR /model
VOLUME ["/model"]

WORKDIR /app

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
