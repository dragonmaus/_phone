ls -F | sed -n -e 's/\*$//p' -e '/-binary$/p' | tr '\n' '\0' | xargs -0r rm -fv 1>&2
redo-always
