FROM docker.io/library/python:3.9-slim-bookworm

LABEL \
  maintainer="Liana64" \
  org.opencontainers.image.source="https://github.com/RosettaCommons/RFdiffusion"

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL
ARG DEBIAN_FRONTEND=noninteractive

ENV \
  NVIDIA_DRIVER_CAPABILITIES="compute,video,utility,graphics" \
  UMASK="0002" \
  LANG=C.UTF-8 \
  TZ="Etc/UTC" \
  USERNAME=rare \
  DEBUG=0 \
  UID=900 \
  GID=900 \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONFAULTHANDLER=1 \
  PIP_ROOT_USER_ACTION=ignore \
  PIP_NO_CACHE_DIR=1 \
  PIP_DISABLE_PIP_VERSION_CHECK=1 \
  PIP_BREAK_SYSTEM_PACKAGES=1 \
  UV_HTTP_TIMEOUT=1000 \
  DGLBACKEND="pytorch"

USER root
WORKDIR /app

RUN \
  groupadd --gid ${GID} ${USERNAME} \
  && useradd --uid ${UID} --gid ${GID} --create-home --shell /bin/bash ${USERNAME} \
  && apt-get update && apt-get install -y --no-install-recommends \
  curl unzip catatonit \
  nano vim tree git \
  && curl -LsSf https://astral.sh/uv/0.5.6/install.sh | sh \
  && . $HOME/.local/bin/env \
  && case "${CHANNEL}" in \
  'stable') \
  curl -fsSL -o /tmp/app.zip "https://github.com/RosettaCommons/RFdiffusion/archive/refs/tags/v${VERSION}.zip" \
  && unzip -q /tmp/app.zip -d /tmp/app \
  && cp -R /tmp/app/RFdiffusion-${VERSION}/* /app \
  ;; \
  'develop') \
  git clone https://github.com/amelie-iska/RFdiffusion.git /app \
  ;; \
  esac \
  && cd /app \
  && uv pip install --system \
  dgl==1.0.2+cu116 -f "https://data.dgl.ai/wheels/cu116/repo.html" \
  torch==1.12.1+cu116 --extra-index-url "https://download.pytorch.org/whl/cu116" \
  e3nn==0.3.3 \
  wandb==0.12.0 \
  pynvml==11.0.0 \
  git+https://github.com/NVIDIA/dllogger#egg=dllogger \
  decorator==5.1.0 \
  hydra-core==1.3.2 \
  pyrsistent==0.19.3 \
  /app/env/SE3Transformer \
  && printf "UpdateMethod=docker\nBranch=master\nPackageVersion=%s\nPackageAuthor=[RareCompute](https://github.com/RareCompute)\n" "${VERSION}" > /app/package_info \
  && chown -R ${UID}:${GID} /app && chmod -R 755 /app \
  && uv pip install --no-deps --system /app \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /root/.cache /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && chsh -s /bin/bash

COPY --chown=${UID}:${GID} ./apps/rfdiffusion/entrypoint.sh /entrypoint.sh
RUN chmod -R 755 /entrypoint.sh

WORKDIR /models
VOLUME ["/models"]

USER ${USERNAME}
WORKDIR /app

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
