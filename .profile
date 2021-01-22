# ~/.profile
# User-specific login shell profile

# Enforce `separation of concerns' between login and interactive shells
shell=$(basename "$SHELL")
: ${shell:=sh}
case $- in
(*i*)
	exec $shell -l -c 'exec $shell -i "$@"' $shell "$@"
	;;
esac

# XDG directories
CONF=${XDG_CONFIG_HOME:-~/.config}
DATA=${XDG_DATA_HOME:-~/.local/share}

# Clean up and augment PATH
path=
ifs=$IFS
IFS=:
for d in ~/bin ~/sbin ~/.cargo/bin ~/.local/bin $PATH
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
su -c hostname `su -c settings get global device_name`

# Set environment
set -a

## Paths
MANPATH=$DATA/man:$MANPATH
PATH=$path

## Shell configuration
ENV=~/.shrc

## Global configuration
DISPLAY= # fool ssh-add into using SSH_ASKPASS
EDITOR=nvim
HOSTNAME=$(hostname -s)
P=$PREFIX
PAGER=less
USER=${USER:-$(id -nu)}

## App-specific configuration
LESS=FMRXi
LESSHISTFILE=-
RIPGREP_CONFIG_PATH=$CONF/ripgrep.conf
SSH_ASKPASS=$(which askpass)

set +a
