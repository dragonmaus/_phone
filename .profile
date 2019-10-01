shell=${SHELL##*/}
case $- in
(*i*) exec $shell -l -c 'exec $shell -i "$@"' $shell "$@" ;;
esac

set -a

ENV=$HOME/.shrc
PATH=$HOME/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH

set +a

agent=$HOME/.ssh/agent.sh
tsu -c pgrep -x ssh-agent >/dev/null || ssh-agent >$agent
busybox reset
busybox clear
cat $HOME/etc/motd
[[ -r $agent ]] && . $agent
