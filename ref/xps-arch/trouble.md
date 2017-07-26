# Arch Recovery

* Insert Arch USB
* Boot -> F12 -> select USB
* mount /dev/nvme0n1p2 /mnt
* mount /dev/nvme0n1p3 /mnt/home
* mount -o rw /dev/nvme0n1p1 /mnt/boot
* arch-chroot /mnt

### UEFI

* fsck /boot
* if corrupt:
  * rm /boot/intel-ucode.img
  * cd /var/cache/pacman/pkg
  * pacman -U intel-ucode-201xxxx
* mkinitcpio -p linux
* bootctl --path=/boot install

