FROM docker.io/library/python:3.12-slim-bookworm

LABEL \
  maintainer="Liana64" \
  org.opencontainers.image.source="https://github.com/bytedance/Protenix"

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
  g++ gcc \
  libc6-dev \
  make zlib1g zlib1g-dev \
  git git-lfs expect zsh wget zip cmake cmake-curses-gui libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev \
  && curl -LsSf https://astral.sh/uv/0.5.6/install.sh | sh \
  && . $HOME/.local/bin/env \
  && uv venv --no-python-downloads /opt/venv \
  && . /opt/venv/bin/activate \
  && case "${CHANNEL}" in \
  'stable') \
  curl -fsSL -o /tmp/app.zip "https://github.com/bytedance/protenix/archive/refs/tags/v${VERSION}.zip" \
  && unzip -q /tmp/app.zip -d /tmp/app \
  && cp -R /tmp/app/Protenix-${VERSION}/LICENSE /app \
  && cp -R /tmp/app/Protenix-${VERSION}/docs /app \
  && cp -R /tmp/app/Protenix-${VERSION}/examples /app \
  && cp -R /tmp/app/Protenix-${VERSION}/notebooks /app \
  && cd /tmp/app/Protenix-${VERSION} \
  && uv pip install -r /tmp/app/Protenix-${VERSION}/requirements.txt \
  ;; \
  'develop') \
  git clone https://github.com/bytedance/Protenix.git /tmp/app \
  && cp -R /tmp/app/LICENSE /app \
  && cp -R /tmp/app/docs /app \
  && cp -R /tmp/app/examples /app \
  && cp -R /tmp/app/notebooks /app \
  && cd /tmp/app \
  && uv pip install -r /tmp/app/requirements.txt \
  ;; \
  esac \
  && uv pip install . \
  && printf "UpdateMethod=docker\nBranch=master\nPackageVersion=%s\nPackageAuthor=[RareCompute](https://github.com/RareCompute)\n" "${VERSION}" > /app/package_info \
  && chown -R ${UID}:${GID} /app && chmod -R 755 /app \
  && chown -R ${UID}:${GID} /opt/venv && chmod -R 755 /opt/venv \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /root/.cache /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && chsh -s /bin/bash

COPY --chown=${UID}:${GID} ./apps/protenix/entrypoint.sh /entrypoint.sh
RUN chmod -R 755 /entrypoint.sh

USER ${USERNAME}
ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
