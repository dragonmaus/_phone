exists() {
	test -e "$1" -a -f "$1" -a -s "$1"
	return $?
}

for ext in sh py sed calc
do
	if exists "$2.$ext"
	then
		redo-ifchange "$2.$ext"
		cp -f "$2.$ext" "$3"
		chmod +x "$3"
		exit 0
	fi
done

echo "$0: Fatal: don't know how to build '$1'" 1>&2
exit 99
