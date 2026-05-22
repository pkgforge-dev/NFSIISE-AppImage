#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    clang    \
    libdecor \
    libusb   \
    lld      \
    sdl2     \

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package nfs2se-git

# If the application needs to be manually built that has to be done down here
git clone --recursive --depth 1 https://github.com/Link4Electronics/NFSIISE
mkdir -p ./AppDir/bin
cd NFSIISE
if [ "$ARCH" = "x86_64" ]; then
    ./compile_nfs x64
else
    ./compile_nfs cpp
fi
mv -v /opt/nfs2se/text.* ./AppDir/bin
mv -v /opt/nfs2se/nfs2se.conf.template ./AppDir/bin/nfs2se.conf
mv -v /opt/nfs2se/install.win ./AppDir/bin
