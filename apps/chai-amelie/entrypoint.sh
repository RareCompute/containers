#!/usr/bin/env bash

EXTRA_FLAGS=""
declare -A FLAG_MAP=(
    [USE_MSA_SERVER]="--use-msa-server"
    [MSA_SERVER_URL]="--msa-server-url"
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
  chai \
  "$@" \
  $EXTRA_FLAGS
