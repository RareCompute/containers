FROM docker.io/library/python:3.13-slim-bookworm

LABEL \
  maintainer="Liana64" \
  org.opencontainers.image.source="https://github.com/RosettaCommons/RFdiffusion"

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
  nano vim tree git \
  # -----------------------------------
  # TODO: Build images with extras
  # -----------------------------------
  # htop tmux psmisc \
  # socat rsync aria2 openssh-server \
  # -----------------------------------
  # TODO: Build images with RDMA & InfiniBand
  # -----------------------------------
  # libibverbs1 librdmacm1 \
  # -----------------------------------
  && curl -fsSL -o /tmp/app.zip "https://github.com/RosettaCommons/RFdiffusion/archive/refs/tags/v${VERSION}.zip" \
  && unzip -q /tmp/app.zip -d /tmp/app \
  && cp -R /tmp/app/RFdiffusion-${VERSION}/LICENSE /app \
  && cp -R /tmp/app/RFdiffusion-${VERSION}/config /app \
  && cp -R /tmp/app/RFdiffusion-${VERSION}/env /app \
  && cp -R /tmp/app/RFdiffusion-${VERSION}/examples /app \
  && cp -R /tmp/app/RFdiffusion-${VERSION}/helper_scripts /app \
  && cp -R /tmp/app/RFdiffusion-${VERSION}/scripts /app \
  && printf "UpdateMethod=docker\nBranch=master\nPackageVersion=%s\nPackageAuthor=[RareCompute](https://github.com/RareCompute)\n" "${VERSION}" > /app/package_info \
  && chown -R ${UID}:${GID} /app && chmod -R 755 /app \
  && curl -LsSf https://astral.sh/uv/0.5.6/install.sh | sh \
  && . $HOME/.local/bin/env \
  && uv venv --no-python-downloads /opt/venv \
  && . /opt/venv/bin/activate \
  && cd /tmp/app/RFdiffusion-${VERSION} \
  && uv pip install "dgl==1.0.2+cu116" -f "https://data.dgl.ai/wheels/cu116/repo.html" \
  "torch==1.12.1+cu116" --extra-index-url "https://download.pytorch.org/whl/cu116" \
  "e3nn==0.3.3" \
  "wandb==0.12.0" \
  "pynvml==11.0.0" \
  "git+https://github.com/NVIDIA/dllogger#egg=dllogger" \
  "decorator==5.1.0" \
  "hydra-core==1.3.2" \
  "pyrsistent==0.19.3" \
  /app/env/SE3Transformer \
  && uv pip install . --no-deps \
  && chown -R ${UID}:${GID} /opt/venv && chmod -R 755 /opt/venv \
  && apt-get purge -y build-essential \
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
