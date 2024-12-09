#!/usr/bin/env bash
git clone --quiet https://github.com/amelie-iska/chai-lab.git /tmp/chai
pushd /tmp/chai > /dev/null || exit
version=$(git rev-list --count --first-parent HEAD)
popd > /dev/null || exit
rm -rf /tmp/chai
printf "1.0.%d" "${version}"
