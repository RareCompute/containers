#!/usr/bin/env bash

CACHE_PATH="${CACHE_PATH:-/cache}"
OUTPUT_PATH="${OUTPUT_PATH:-/predictions}"

EXTRA_FLAGS=""
declare -A FLAG_MAP=(
    [CACHE_PATH]="--cache"
    [DATA_PATH]="--out_dir"
    [DEVICE_TYPE]="--accelerator"
    [DEVICES_COUNT]="--devices"
    [RECYCLING_STEPS]="--recycling_steps"
    [SAMPLING_STEPS]="--sampling_steps"
    [DIFFUSION_SAMPLES]="--diffusion_samples"
    [OUTPUT_FORMAT]="--output_format"
    [WORKERS]="--num_workers"
    [OVERRIDE]="--override"
    [USE_MSA_SERVER]="--use_msa_server"
    [MSA_SERVER_URL]="--msa_server_url"
    [MSA_PAIRING_STRATEGY]="--msa_pairing_strategy"
    [WRITE_FULL_PAE]="--write_full_pae"
    [WRITE_FULL_PDE]="--write_full_pde"
)

for VAR in "${!FLAG_MAP[@]}"; do
    if [ -n "${!VAR}" ]; then
        EXTRA_FLAGS+=" ${FLAG_MAP[$VAR]} ${!VAR}"
    fi
done

exec \
  boltz \
  "$@" \
  $EXTRA_FLAGS
