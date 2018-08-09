function distro {
  case "$(uname -a) $(test -e /etc/issue && cat /etc/issue)" in
    *-(ARCH|arch)[^A-Za-z]*) echo ArchLinux ;;
    *[Uu]buntu*)             echo Ubuntu ;;
    *Darwin*)                echo OSX ;;
  esac
}
