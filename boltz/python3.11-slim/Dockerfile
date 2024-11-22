# Base image
# ----------------------
ARG PROJECT_NAME=boltz
ARG PROJECT_URL=https://github.com/jwohlwend/boltz.git
ARG BASE_IMAGE=python:3.11-slim
FROM ${BASE_IMAGE} AS builder

# Build
# ----------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  build-essential \
  python3-venv \
  && python3 -m venv /opt/venv \
  && . /opt/venv/bin/activate \
  && git clone https://github.com/jwohlwend/boltz.git /app \
  && pip install --no-cache-dir --upgrade pip \
  && pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu \
  && pip install --no-cache-dir boltz \
  && apt-get purge -y git build-essential \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Metadata
# ----------------------
FROM ${BASE_IMAGE}

LABEL base_image=${BASE_IMAGE} \
  software=${PROJECT_NAME} \
  about.home=${PROJECT_URL} \
  about.summary="Biomolecular interaction model for 3D protein structure prediction" \
  about.tags="Model" \
  about.license="MIT" \
  about.license_file="https://github.com/jwohlwend/boltz/blob/main/LICENSE" \
  version="1" 

# Configuration
# ----------------------
ARG USERNAME=rare
ARG USER_UID=900
ARG USER_GID=900

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV PATH="/opt/venv/bin:$PATH"

# Installation
# ----------------------
RUN groupadd --gid $USER_GID $USERNAME && \
  useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash $USERNAME

COPY --from=builder --chown=$USER_UID:$USER_GID /opt/venv /opt/venv
COPY --from=builder --chown=$USER_UID:$USER_GID /app /app
COPY --from=builder --chown=$USER_UID:$USER_GID /app/LICENSE /app/LICENSE
COPY --from=builder --chown=$USER_UID:$USER_GID /app/README.md /app/README.md
COPY --from=builder --chown=$USER_UID:$USER_GID /app/docs /app/docs
COPY --from=builder --chown=$USER_UID:$USER_GID /app/examples /app/examples
COPY --from=builder --chown=$USER_UID:$USER_GID /app/scripts /app/scripts

WORKDIR /app
USER $USERNAME
ENTRYPOINT ["boltz"]
