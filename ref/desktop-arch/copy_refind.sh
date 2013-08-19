#!/bin/bash

cp -vp /usr/share/refind/refind_x64.efi /boot/efi/EFI/refind/
cp -vp /usr/share/refind/drivers_x64/*  /boot/efi/EFI/tools/drivers
cp -vp /usr/share/refind/icons/*        /boot/efi/EFI/refind/icons
cp -vp /usr/share/refind/fonts/*        /boot/efi/EFI/refind/fonts

