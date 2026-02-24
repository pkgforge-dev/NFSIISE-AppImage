#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
tee -a /etc/pacman.conf <<EOF

[multilib]
Include = /etc/pacman.d/mirrorlist
EOF
pacman -Syu --noconfirm \
    lib32-libdecor      \
    lib32-libglvnd      \
    lib32-libpulse      \
    lib32-mesa          \
    sdl2                \
    yasm
    #    lib32-libpipewire   \
    #    lib32-pipewire      \
#    lib32-pipewire-jack \

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
make-aur-package nfs2se-git

# If the application needs to be manually built that has to be done down here
mkdir -p ./AppDir/bin
mv -v /opt/nfs2se/text.* ./AppDir/bin
mv -v /opt/nfs2se/nfs2se.conf.template ./AppDir/bin/nfs2se.conf
mv -v /opt/nfs2se/install.win ./AppDir/bin
