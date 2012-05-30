#!/bin/bash

GIT=/usr/bin/git

BINDIR=`dirname $0`

if [ -x "$BINDIR/gb-$1.sh" ]; then
  exec "$BINDIR/gb-$1.sh" $2 $3 $4 $5 $6 $7 $8 $9
else
  echo "gb: wrong command."
  echo "gb: use 'gb help' to see help."
  exit 1
fi
