# ~/.profile

# Enforce separation of concerns (login / interactive)
shell="${SHELL##*/}"
case "$-" in
(*i*) exec "$shell" -l -c 'exec "$shell" -i "$@"' "$shell" "$@" ;;
esac

# XDG directories
cache_home="${XDG_CACHE_HOME:-"$HOME/.cache"}"
config_home="${XDG_CONFIG_HOME:-"$HOME/.config"}"
data_home="${XDG_DATA_HOME:-"$HOME/.local/share"}"

# Clean up and augment PATH
path=
ifs="$IFS"
IFS=:
for d in $HOME/bin $HOME/.cargo/bin $HOME/.local/bin $HOME/bin/ext $PATH
do
	d="$( realpath "$d" 2> /dev/null || echo "$d" )"
	case ":$path:" in
	(*":$d:"*) continue ;;
	esac
	path="$path:$d"
done
IFS="$ifs"
path="${path#:}"

# Set environment
set -a

# Paths
PATH="$path"

# Shell configuration
ENV="$HOME/.shrc"

# Global configuration
DISPLAY=  # fool ssh-add into using SSH_ASKPASS
EDITOR="$( which nvim vim vi 2> /dev/null | head -1 )"
LC_COLLATE=C

# App-specific configuration
LEDGER_FILE=/sdcard/Sync/Ledger/ledger.journal
RIPGREP_CONFIG_PATH="$config_home/ripgrep/config"
SSH_ASKPASS="$( which askpass )"

set +a

umask 077
