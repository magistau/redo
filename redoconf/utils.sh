NL="
"

# Like 'echo', but never processes backslash escapes.
# (Some shells' builtin echo do, and some don't, so this
# is safer.)
xecho() {
	printf '%s\n' "$*"
}

# Returns true if string $1 contains the line $2.
# Lines are delimited by $NL.
contains_line() {
	case "$NL$1$NL" in
		*"$NL$2$NL"*) return 0 ;;
		*) return 1 ;;
	esac
}

# Split the words from $1, returning a string where the
# words are separated by $NL instead.
#
# To allow words including whitespace, you can backslash
# escape the whitespace (eg. hello\ world).  Backslashes
# will be removed from the output string.
#
# We can use this to read pkg-config output, among other
# things.
# 
# TODO: this implementation also handles quotes, e.g.:
#   $ rc_splitwords '"foo bar" baz'
#   foo bar
#   baz
# Not sure if this is good or not, but the previous
# implementation (using `read`) did not do this.
rc_splitwords() {
	xecho "$1" | xargs printf '%s\n'
}

# Escape single-quote characters so they can
# be included as a sh-style single-quoted string.
shquote() {
	printf "'%s'" "$(xecho "$1" | sed -e "s,','\\\\'',g")"
}
