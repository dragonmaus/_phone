# ~/.profile

# User-specific shell profile

# Ensure that `echo' is sane
case "$KSH_VERSION" in
(*'MIRBSD KSH'*|*'LEGACY KSH'*|*'PD KSH'*)
  echo() {
    print -R "$@"
  }
  ;;
(*)
  echo() {
    case "$1" in
    (-n)
      shift
      printf '%s' "$*"
      ;;
    (*)
      printf '%s\n' "$*"
      ;;
    esac
  }
  ;;
esac

# Enforce `separation of concerns' between login and interactive shells
shell=`basename $SHELL`
shell=${shell:-sh}
case $- in
(*i*)
  exec $shell -l -c 'exec $shell -i "$@"' $shell "$@"
  ;;
esac

# Pull in Nix configuration
test -e ~/.nix-profile/etc/profile.d/nix.sh && . ~/.nix-profile/etc/profile.d/nix.sh

# XDG directories
CONF=${XDG_CONFIG_HOME:-~/.config}
DATA=${XDG_DATA_HOME:-~/.local/share}

# Clean up and augment PATH
path=
ifs=$IFS
IFS=:
for d in ~/bin ~/.cargo/bin ~/.local/bin ~/bin/ext $PATH
do
  case /$d/ in
  (*/.nix-profile/*|*/nix/*)
    ;;
  (*)
    d=`readlink -f $d 2> /dev/null || echo $d`
    ;;
  esac
  case ":$path:" in
  (*:$d:*)
    continue
    ;;
  esac
  path=$path:$d
done
IFS=$ifs
path=${path#:}

# Ensure that correct hostname is set
su -c hostname `su -c settings get global device_name`

# Set environment
set -a

## Paths
PATH=$path

## Shell configuration
ENV=$CONF/shell/init.sh

## Global configuration
DISPLAY= # fool ssh-add into using SSH_ASKPASS
EDITOR=`which nvim vim vi 2> /dev/null | head -1`
HOSTNAME=`hostname -s`
LC_COLLATE=C
P=$PREFIX
PAGER=less; MANPAGER="$PAGER -s"
USER=${USER:-`id -nu`}

## App-specific configuration
LESS=FMRXi
LESSHISTFILE=-
RIPGREP_CONFIG_PATH=$CONF/ripgrep/config
SSH_ASKPASS=`which askpass`

set +a
