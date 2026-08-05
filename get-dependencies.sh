#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    clang          \
    cmake          \
    libdecor       \
    lld            \
    sdl3
#    pipewire-audio \
#    pipewire-jack  \


echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
echo "Making nightly build of NFSIISE..."
echo "---------------------------------------------------------------"
REPO="https://github.com/Link4Electronics/NFSIISE"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --recursive --depth 1 "$REPO" ./NFSIISE
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./NFSIISE
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
cd "../Need For Speed II SE"
mv -v text.* ../../AppDir/bin
mv -v nfs2se ../../AppDir/bin
mv -v nfs2se.conf.template ../../AppDir/bin/nfs2se.conf
mv -v install.win ../../AppDir/bin
mv -v nfs2se.png ../../AppDir
mv -v nfs2se.desktop ../../AppDir
