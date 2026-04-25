#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q nfs2se-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/32x32/apps/nfs2se.png
export DESKTOP=/usr/share/applications/nfs2se.desktop
export STARTUPWMCLASS=ld-linux.so.2
export DEPLOY_OPENGL=1
export DEPLOY_PULSE=1
export LIB_DIR=/usr/lib32

# Deploy dependencies
quick-sharun /opt/nfs2se/nfs2se

# Additional changes can be done in between here
echo 'ANYLINUX_DO_NOT_LOAD_LIBS=libpipewire-0.3.so*:${ANYLINUX_DO_NOT_LOAD_LIBS}' >> ./AppDir/.env

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
