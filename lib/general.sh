function distro {
  case "$(uname -a) $(cat /etc/issue)" in
    *-ARCH[^A-Za-z]*) echo 'ArchLinux' ;;
    *[Uu]buntu*) echo 'Ubuntu' ;;
  esac
}
