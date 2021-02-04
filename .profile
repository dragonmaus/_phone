# ~/.profile
# User-level login shell configuration

# Enforce separation of concerns between login and interactive shells
shell=$(basename $SHELL)
case $- in
(*i*)
	exec $shell -l -c 'exec $shell -i "$@"' $shell "$@"
	;;
esac

# Clean up and augment PATH
path=
ifs=$IFS
IFS=:
for d in ~/bin ~/sbin ~/.cargo/bin ~/.local/bin ~/.local/python/bin $PATH
do
	d=$(readlink -f $d 2> /dev/null || echo $d)
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
su -c hostname $(su -c settings get global device_name)

# Set environment
set -a

## Paths
MANPATH=~/.local/share/man:
PATH=$path

## Interactive shell configuration
ENV=~/.shrc

## Global configuration
DISPLAY=  # fool ssh-add into using SSH_ASKPASS
EDITOR=nvim
HOSTNAME=$(hostname -s)
P=$PREFIX
USER=$(id -nu)

## Command-specific configuration
LESS=Ri
LESSHISTFILE=-
PASSWORD_STORE_DIR=/sdcard/.password-store
PYTHONUSERBASE=~/.local/python
RIPGREP_CONFIG_PATH=~/.config/ripgrep.conf
SSH_ASKPASS=$(which askpass)

set +a
