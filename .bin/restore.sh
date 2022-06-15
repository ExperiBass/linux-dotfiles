#!/bin/bash

# Restores from a backup.

backup=$1 # path to backup dir
pkglistdir=$2
aurpkglist="$2/aur-packages.txt"
pkglist="$2/packages.txt"
dotfiles="https://github.com/experibass/linux-dotfiles"

# set default yay options
yay --batchinstall --sudoloop --cleanafter --save

# Make required dirs
mkdir -p ~/Builds/kernel
mkdir -p ~/tmp

# start
echo "Restoring config..."
cd ~ || exit 1
git clone --no-checkout $dotfiles ./tmp
mv ./tmp/.git ~
rmdir ./tmp
git checkout master

sudo sed -ri 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]+/& quiet intel_iommu=on iommu=pt pcie_ports=compat/' /etc/default/grub

echo "Restoring files..."
cp -ruv "$backup" /

echo "Creating swapfile..."
dd if=/dev/zero of=/swapfile bs=10M count=2000 # 20gb, ram+hibernate
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

echo "Installing packages..."
yay -S --needed --nocleanmenu --nodiffmenu --noeditmenu --noremovemake \
    --noupgrademenu --answerclean=N --answerdiff=N --answerupgrade=Y --noconfirm \
    - < "$pkglist"

echo "Installing AUR packages..."
yay -S --needed --nocleanmenu --nodiffmenu --noeditmenu --noremovemake \
    --noupgrademenu --answerclean=N --answerdiff=N --answerupgrade=Y --noconfirm \
    - < "$aurpkglist"

echo "Compiling kernel..."
~/.bin/buildkernel.sh