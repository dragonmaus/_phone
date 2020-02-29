# ~/.profile

# User-specific shell profile

# Ensure that `echo' is sane
case "$KSH_VERSION" in
(*MIRBSD\ KSH*|*LEGACY\ KSH*|*PD\ KSH*)
  echo() {
    print -R "$@"
  }
  ;;
(*)
  echo() {
    if [[ "$1" = -n ]]
    then
      shift
      printf '%s' "$*"
    else
      printf '%s\n' "$*"
    fi
  }
  ;;
esac

# Enforce `separation of concerns' (login / interactive)
shell="$( basename "$SHELL" )"
shell="${shell:-sh}"
case "$-" in
(*i*)
  exec "$shell" -l -c 'exec "$shell" -i "$@"' "$shell" "$@"
  ;;
esac

# XDG directories
CONF="${XDG_CONFIG_HOME:-"$HOME/.config"}"
DATA="${XDG_DATA_HOME:-"$HOME/.local/share"}"

# Clean up and augment PATH
path=
ifs="$IFS"
IFS=:
for d in "$HOME/bin" "$HOME/.cargo/bin" "$HOME/.local/bin" "$HOME/bin/ext" $PATH
do
  d="$( readlink -f "$d" 2> /dev/null || echo "$d" )"
  case ":$path:" in
  (*":$d:"*)
    continue
    ;;
  esac
  path="$path:$d"
done
IFS="$ifs"
path="${path#:}"

# Set environment
set -a

## Paths
PATH="$path"

## Shell configuration
ENV="$CONF/shell/init.sh"

## Global configuration
DISPLAY= # fool ssh-add into using SSH_ASKPASS
EDITOR="$( which nvim vim vi 2> /dev/null | head -1 )"
HOSTNAME="${HOSTNAME:-"$( hostname -s )"}"
LC_COLLATE=C
P="$PREFIX"
PAGER=less; MANPAGER="$PAGER -s"
USER="${USER:-"$( id -nu )"}"

## App-specific configuration
LESS=FMRi
RIPGREP_CONFIG_PATH="$CONF/ripgrep/config"
SSH_ASKPASS="$( which askpass )"

set +a

# Set umask
umask 077
