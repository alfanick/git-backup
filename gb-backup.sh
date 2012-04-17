#!/bin/bash

DIR=`pwd`

GIT=/usr/bin/git
GB="`dirname $0`/gb.sh"

if [ ! -e "$DIR/.git" ]; then
  echo "gb-backup: not in git repository."
  exit 1
else
  $GIT ls-files -d -z | xargs -0 git update-index --remove
  $GIT add .
  $GIT commit -am "`date '+%m%d%H%M%Y.%S'`" &> /dev/null
  echo "gb-backup: commited changes."

  $GB sync
fi
