#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    qt6-imageformats \
    qt6-tools

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building ClassicImageViewer..."
echo "---------------------------------------------------------------"
REPO="https://github.com/classicimageviewer/ClassicImageViewer"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./ClassicImageViewer
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ClassicImageViewer
qmake6 .
make -s clean
make -j$(nproc)
mv -v build/civ ../AppDir/bin
