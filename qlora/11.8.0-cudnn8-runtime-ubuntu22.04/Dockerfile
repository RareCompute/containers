# Base image
# ----------------------
ARG PROJECT_NAME=qlora
ARG PROJECT_URL=https://github.com/artidoro/qlora
ARG BASE_IMAGE=nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04
FROM ${BASE_IMAGE} AS builder

# Build
# ----------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  build-essential \
  python3 \
  python3-venv \
  && python3 -m venv /opt/venv \
  && . /opt/venv/bin/activate \
  && git clone https://github.com/artidoro/qlora /app \
  && pip install --no-cache-dir --upgrade pip \
  && pip install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 \
  && pip install --no-cache-dir -r /app/requirements.txt \
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
  about.summary="QLoRA: Efficient Finetuning of Quantized LLMs" \
  about.tags="Model" \
  about.license="MIT" \
  about.license_file="https://github.com/artidoro/qlora" \
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
  useradd --uid $USER_UID --gid $USER_GID --create-home --shell /bin/bash $USERNAME \
  && apt-get update && apt-get install -y --no-install-recommends python3 \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder --chown=$USER_UID:$USER_GID /opt/venv /opt/venv
COPY --from=builder --chown=$USER_UID:$USER_GID /app /app

WORKDIR /app
USER $USERNAME
ENTRYPOINT ["python /app/qlora.py"]
