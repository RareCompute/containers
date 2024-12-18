#!/usr/bin/env bash

EXTRA_FLAGS=""
declare -A FLAG_MAP=(
  [INPUT]="--input"
  [INPUT_JSON_PATH]="--input_json_path"
  [DUMP_DIR]="--dump_dir"
  [DATA_TYPE]="--dtype"
  [OUT_DIR]="--out_dir"
  [USE_MSA]="--use_msa"
  [USE_MSA_SERVER]="--use_msa_server"
)

for VAR in "${!FLAG_MAP[@]}"; do
    if [ -n "${!VAR}" ]; then
        VALUE_LOWER=$(echo "${!VAR}" | tr '[:upper:]' '[:lower:]')
        if [[ "$VALUE_LOWER" == "true" ]]; then
            EXTRA_FLAGS+=" ${FLAG_MAP[$VAR]}"
        elif [[ "$VALUE_LOWER" != "false" ]]; then
            EXTRA_FLAGS+=" ${FLAG_MAP[$VAR]} ${!VAR}"
        fi
    fi
done

exec \
  protenix \
  "$@" \
  $EXTRA_FLAGS
