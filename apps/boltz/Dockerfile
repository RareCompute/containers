FROM docker.io/library/python:3.12-slim-bookworm

LABEL \
  maintainer="Liana64" \
  org.opencontainers.image.source="https://github.com/jwohlwend/boltz"

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
  PIP_ROOT_USER_ACTION=ignore \
  PIP_NO_CACHE_DIR=1 \
  PIP_DISABLE_PIP_VERSION_CHECK=1 \
  PIP_BREAK_SYSTEM_PACKAGES=1

USER root
WORKDIR /app

# TODO: Add uv
RUN \
  groupadd --gid ${GID} ${USERNAME} \
  && useradd --uid ${UID} --gid ${GID} --create-home --shell /bin/bash ${USERNAME} \
  && apt-get update && apt-get install -y --no-install-recommends \
  curl \
  jq \
  unzip \
  build-essential \
  catatonit \
  python3-venv \
  && python3 -m venv /opt/venv \
  && . /opt/venv/bin/activate \
  && curl -fsSL -o /tmp/app.zip "https://github.com/jwohlwend/boltz/archive/refs/tags/v${VERSION}.zip" \
  && unzip -q /tmp/app.zip -d /app \
  && mv /app/boltz-${VERSION}/LICENSE /app \
  && mv /app/boltz-${VERSION}/README.md /app \
  && mv /app/boltz-${VERSION}/pyproject.toml /app \
  && mv /app/boltz-${VERSION}/docs /app \
  && mv /app/boltz-${VERSION}/examples /app \
  && mv /app/boltz-${VERSION}/scripts /app \
  && mv /app/boltz-${VERSION}/src /app \
  && printf "UpdateMethod=docker\nBranch=master\nPackageVersion=%s\nPackageAuthor=[RareCompute](https://github.com/RareCompute)\n" "${VERSION}" > /app/package_info \
  && pip install --no-cache-dir \
  torch \
  torchvision \
  torchaudio \
  && pip install --no-cache-dir --upgrade . \
  && chown -R ${UID}:${GID} /app && chmod -R 755 /app \
  && chown -R ${UID}:${GID} /opt/venv  && chmod -R 755 /opt/venv \
  && apt-get purge -y build-essential \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /root/.cache /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --chown=${UID}:${GID} ./apps/boltz/entrypoint.sh /entrypoint.sh

USER ${USERNAME}
WORKDIR /cache
VOLUME ["/cache"]

WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
