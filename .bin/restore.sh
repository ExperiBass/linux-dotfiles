#!/bin/bash

# Restores from a backup.

backup=$1 # path to backup dir
pkglistdir=$2
aurpkglist="$2/aur-packages.txt"
pkglist="$2/packages.txt"
dotfiles="https://github.com/experibass/linux-dotfiles"

# set default yay options
yay --batchinstall --sudoloop --cleanafter --save

echo "Restoring config..."
mkdir ~/tmp
git clone --no-checkout $dotfiles ./tmp
mv ./tmp/.git ~
rmdir ./tmp
git checkout master

echo "Restoring files..."
cp -ruv $backup /
echo "Installing packages..."
yay -S --needed --nocleanmenu --nodiffmenu --noeditmenu --noremovemake \
    --noupgrademenu --answerclean=N --answerdiff=N --answerupgrade=Y --noconfirm \
    - < $pkglist
echo "Installing AUR packages..."
yay -S --needed --nocleanmenu --nodiffmenu --noeditmenu --noremovemake \
    --noupgrademenu --answerclean=N --answerdiff=N --answerupgrade=Y --noconfirm \
    - < $aurpkglist
echo "Done."