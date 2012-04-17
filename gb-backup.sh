#!/bin/bash

DIR=`pwd`

GIT=/usr/bin/git
GB="`dirname $0`/gb.sh"

if [ ! -e "$DIR/.git" ]; then
  echo "gb-backup: not in git repository."
  exit 1
else
  # check for removed and new files
  $GIT ls-files -d -z | xargs -0 git update-index --remove
  $GIT add . 
  
  if $GIT diff-index --quiet HEAD -- &> /dev/null; then
    echo "gb-backup: no changes."
  else
    $GIT commit -am "`date +'%d.%m.%Y at %T'`" &> /dev/null
    echo "gb-backup: commited changes."

    $GB sync
  fi
fi
