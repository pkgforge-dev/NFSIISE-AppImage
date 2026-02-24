#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q nfs2se-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/32x32/apps/nfs2se.png
export DESKTOP=/usr/share/applications/nfs2se.desktop
export OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/nfs2se #/opt/nfs2se

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
