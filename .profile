shell="${SHELL##*/}"
case "$-" in
(*i*) exec "$shell" -l -c 'exec "$shell" -i "$@"' "$shell" "$@" ;;
esac

set -a

ENV="$HOME/.shrc"
PATH="$HOME/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

LEDGER_FILE=/sdcard/Sync/Ledger/ledger.journal

set +a
