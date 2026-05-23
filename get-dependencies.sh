#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
# pacman -Syu --noconfirm PACKAGESHERE

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
git clone https://github.com/classicimageviewer/ClassicImageViewer
mkdir -p ./AppDir/bin

cd ClassicImageViewer
qmake .
make -s clean
make -j$(nproc)
cp -v build/civ ../AppDir/bin
cp -v install/usr/share/icons/hicolor/256x256/civ.png ../AppDir
cp -r install/usr/share ../AppDir/usr
