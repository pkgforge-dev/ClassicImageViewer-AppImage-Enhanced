#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/classicimageviewer/ClassicImageViewer/refs/heads/main/install/usr/share/icons/hicolor/256x256/apps/civ.png
export DESKTOP=https://raw.githubusercontent.com/classicimageviewer/ClassicImageViewer/refs/heads/main/install/usr/share/applications/classicimageviewer.desktop

# Deploy dependencies
quick-sharun ./AppDir/bin/civ

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --simple-test ./dist/*.AppImage
