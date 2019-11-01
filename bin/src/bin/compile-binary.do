redo-always
which tcc cc 2> /dev/null | head -1 > "$3"
redo-stamp < "$3"
