# Creation

Create a partition

part=/dev/__
cryptsetup -y -v luksFormat --type luks2 $part

name=home
cryptsetup open $part $name
mkfs.ext4 /dev/mapper/$name
