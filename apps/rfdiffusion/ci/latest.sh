#!/usr/bin/env bash
channel=$1

if [[ "${channel}" == "stable" ]]; then
  version=$(curl -sX GET "https://api.github.com/repos/RosettaCommons/RFdiffusion/releases/latest" | jq --raw-output '.tag_name' 2>/dev/null)
  version="${version#*v}"
  version="${version#*release-}"
  printf "%s" "${version}"
fi

if [[ "${channel}" == "develop" ]]; then
  git clone --quiet https://github.com/amelie-iska/RFdiffusion.git /tmp/rfdiffusion
  pushd /tmp/rfdiffusion > /dev/null || exit
  version=$(git rev-list --count --first-parent HEAD)
  popd > /dev/null || exit
  rm -rf /tmp/rfdiffusion
  printf "%s" "${version}"
fi
