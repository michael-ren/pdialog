#!/bin/sh

DEFAULT_DIR=~/.password-store

DIR="${PASSWORD_STORE_DIR:-${DEFAULT_DIR}}"

HEIGHT="${PDIALOG_HEIGHT:-10}"

WIDTH="${PDIALOG_WIDTH:-40}"

TIMEOUT="${PDIALOG_TIMEOUT:-30}"

if [ "$#" -eq 0 ]; then
	COMMAND=less
else
	COMMAND="${1:-less}"
	shift
fi


if which gpg2 >/dev/null 2>&1; then
	GPG=gpg2
elif which gpg >/dev/null 2>&1; then
	GPG=gpg
else
	>&2 printf 'No gpg command found\n' && exit 2
fi


while true; do
	DIR="$(realpath "$DIR")"
	SELECTION="$(timeout --foreground "$TIMEOUT" dialog --fselect "$DIR"/ "$HEIGHT" "$WIDTH" --output-fd 1)"

	[ "$?" -eq 0 ] || break

	if [ -f "$SELECTION" ]; then
		"$GPG" -q -d "$SELECTION" | timeout --foreground "$TIMEOUT" "$COMMAND" "$@"
		DIR="$(dirname "$SELECTION")"
	else
		dialog --msgbox "'$SELECTION' is not a file" "$HEIGHT" "$WIDTH"
		[ "$?" -eq 0 ] || break
		[ -d "$SELECTION" ] && DIR="$SELECTION"
	fi
done
