#!/usr/bin/env bash
git clone --quiet https://github.com/artidoro/qlora.git /tmp/qlora
pushd /tmp/qlora > /dev/null || exit
version=$(git rev-list --count --first-parent HEAD)
popd > /dev/null || exit
rm -rf /tmp/qlora
printf "1.0.%d" "${version}"
