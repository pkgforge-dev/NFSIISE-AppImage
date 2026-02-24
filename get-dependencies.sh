#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
#    lib32-libgl      \
#    lib32-libx11     \
#    lib32-libxcursor \
#    lib32-libxext    \
#    lib32-libxrender \
pacman -Syu --noconfirm --chaotic-aur \
    lib32-glibc      \
    lib32-libpulse \
    libdecor         \
    sdl2             \
    yasm

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
make-aur-package lib32-sdl2
make-aur-package nfs2se-git

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
