function distro {
  if [ ! -e /tmp/golly-distro ]; then
    case "$(uname -a) $(test -e /etc/issue && cat /etc/issue)" in
      *-[aA][rR][cC][hH][^A-Za-z]*) echo ArchLinux > /tmp/golly-distro ;;
      *[Uu]buntu*)                  echo Ubuntu > /tmp/golly-distro ;;
      *Darwin*)                     echo OSX > /tmp/golly-distro ;;
    esac
  fi
  cat /tmp/golly-distro
}
