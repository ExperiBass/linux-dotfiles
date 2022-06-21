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

sed -ri 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]+/& quiet intel_iommu=on iommu=pt pcie_ports=compat/' /etc/default/grub

echo "Restoring files..."
cp -ruv $backup /

echo "Creating swapfile..."
dd if=/dev/zero of=/swapfile bs=10M count=2000 # 20gb, ram+hibernate
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

echo "Installing packages..."
yay -S --needed --nocleanmenu --nodiffmenu --noeditmenu --noremovemake \
    --noupgrademenu --answerclean=N --answerdiff=N --answerupgrade=Y --noconfirm \
    - < $pkglist

echo "Installing AUR packages..."
yay -S --needed --nocleanmenu --nodiffmenu --noeditmenu --noremovemake \
    --noupgrademenu --answerclean=N --answerdiff=N --answerupgrade=Y --noconfirm \
    - < $aurpkglist

echo "Compiling kernel..."
# https://wiki.t2linux.org/guides/kernel/
export MAKEFLAGS=-j$(nproc)
cd ~/Builds
mkdir -p kernel
cd kernel
git clone --depth=1 https://github.com/Redecorating/mbp-16.1-linux-wifi patches
source patches/PKGBUILD
wget https://www.kernel.org/pub/linux/kernel/v${pkgver//.*}.x/linux-${pkgver}.tar.xz
tar xf $_srcname.tar.xz
cd $_srcname
git clone --depth=1 https://github.com/t2linux/apple-bce-drv drivers/staging/apple-bce
git clone --depth=1 https://github.com/Redecorating/apple-ib-drv drivers/staging/apple-ibridge # Redecoratings patch works
for patch in ../patches/*.patch; do
    patch -Np1 < $patch
done
zcat /proc/config.gz > .config
make olddefconfig
scripts/config --module apple-ibridge
scripts/config --module apple-bce
make
make modules_install
make install
mkinitcpio -k /boot/vmlinuz -c /etc/mkinitcpio.conf -g /boot/initramfs.img
grub-mkconfig -o /boot/grub/grub.cfg

echo "Removing unneeded/broken packages..."
yay -Rns --noconfirm xf86-video-intel linux-t2 linux-t2-headers
yay -Rdd pipewire wireplumber pipewire-alsa

echo "Done."