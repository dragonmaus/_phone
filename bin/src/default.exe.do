exists() {
	test -e "$1" && test -f "$1" && test -s "$1"
	return $?
}

check() {
	for ext in sh sed
	do
		if exists "$2.$ext"
		then
			file="$2.$ext"
			kind=script
			return 0
		fi
	done
	echo "$0: Fatal: don't know how to build '$1'" 1>&2
	exit 99
}

check "$@"

case "$kind" in
(script)
	redo-ifchange "$file"

	cat < "$file" > "$3"
	chmod +x "$3"
	;;
esac
