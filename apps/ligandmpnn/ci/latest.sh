#!/usr/bin/env bash

git clone --quiet https://github.com/dauparas/LigandMPNN /tmp/ligandmpnn
pushd /tmp/ligandmpnn > /dev/null || exit
version=$(git rev-list --count --first-parent HEAD)
popd > /dev/null || exit
rm -rf /tmp/ligandmpnn
printf "%s" "${version}"
