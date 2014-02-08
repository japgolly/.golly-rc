sudo pacman -Sy --needed --noconfirm -- \
  nfs-utils \
  nfsidmap \
  rpcbind

for s in nfsd rpcbind rpc-mountd rpc-idmapd rpc-gssd; do
  sudo systemctl enable $s
done

