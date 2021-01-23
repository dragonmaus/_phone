#!/bin/sh

name=$(basename "$0" .sh)
real=$(readlink -f "$0")
next=$(which -a "$name" | grep -Fvx "$real" | head -1)

setsid -w "$next" -Nfn "$@"
exec "$next" "$@"
