#!/usr/bin/env bash

echo -n 'Rare Compute Devserver '
echo ${VERSION}
echo '
───────────────────────────────────────'
echo "
User UID:    ${UID}
User GID:    ${GID}
───────────────────────────────────────"

exec \
  /bin/bash
