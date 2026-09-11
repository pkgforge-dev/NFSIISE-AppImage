#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm clang cmake lld sdl3

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

echo "Building NFSIISE..."
echo "---------------------------------------------------------------"
REPO="https://github.com/Link4Electronics/NFSIISE"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --recursive --depth 1 "$REPO" ./NFSIISE
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cmake -S ./NFSIISE -B build -DCMAKE_BUILD_TYPE=Release ..
cmake --build build -j$(nproc)
mv -v "NFSIISE/Need For Speed II SE/text.*" "NFSIISE/Need For Speed II SE/nfs2se" "NFSIISE/Need For Speed II SE/install.win" ./AppDir/bin
mv -v "NFSIISE/Need For Speed II SE/nfs2se.conf.template" ./AppDir/bin/nfs2se.conf
