#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

#exec ck-launch-session gnome-session

fusion-icon &

redshift -l -33.8683:151.2086 &

exec ck-launch-session startxfce4

#exec i3

