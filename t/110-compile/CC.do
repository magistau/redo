exec >$3
cat <<-EOF
	#!/bin/sh
	cc -Wall -o /dev/fd/1 -c "\$1"
EOF
chmod a+x $3
