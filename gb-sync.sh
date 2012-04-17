#!/bin/bash

DIR=`pwd`

GIT=/usr/bin/git
GB="`dirname $0`/gb.sh"

if [ ! -e "$DIR/.git" ]; then
  echo "gb-sync: not in git repository."
  exit 1
else
  if $GIT push backup master &> /dev/null ; then
    echo "gb-sync: sent to backup server."
  else
    echo "gb-sync: *cannot send* to backup server."
    echo "gb-sync: retry later."
    exit 1
  fi
fi
