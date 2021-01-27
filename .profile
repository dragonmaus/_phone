# ~/.profile
# User-specific login shell profile

# Enforce `separation of concerns' between login and interactive shells
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
MANPATH=~/.local/share/man:$MANPATH
PATH=$path

## Shell configuration
ENV=~/.shrc

## Global configuration
DISPLAY=  # fool ssh-add into using SSH_ASKPASS
EDITOR=nvim
HOSTNAME=$(hostname -s)
P=$PREFIX

## App-specific configuration
LESS=Ri
LESSHISTFILE=-
PYTHONUSERBASE=~/.local/python
RIPGREP_CONFIG_PATH=~/.config/ripgrep.conf
SSH_ASKPASS=$(which askpass)

set +a
