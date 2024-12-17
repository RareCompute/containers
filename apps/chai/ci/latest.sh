#!/usr/bin/env bash
channel=$1

if [[ "${channel}" == "stable" ]]; then
  version=$(curl -sX GET "https://api.github.com/repos/chaidiscovery/chai-lab/releases/latest" | jq --raw-output '.tag_name' 2>/dev/null)
  version="${version#*v}"
  version="${version#*release-}"
  printf "%s" "${version}"
fi

if [[ "${channel}" == "develop" ]]; then
  git clone --quiet https://github.com/amelie-iska/chai-lab.git /tmp/chai
  pushd /tmp/chai > /dev/null || exit
  version=$(git rev-list --count --first-parent HEAD)
  popd > /dev/null || exit
  rm -rf /tmp/chai
  printf "%s" "${version}"
fi
