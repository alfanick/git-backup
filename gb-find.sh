#!/bin/bash

DIR=`pwd`

GIT=/usr/bin/git
GB="`dirname $0`/gb.sh"

if [ ! -e "$DIR/.git" ]; then
  echo "gb-grep: not in git repository."
  exit 1
else
  if [ ! -n "$1" ]; then
    echo "gb-grep: add text you want to find."
    exit 1
  else
    RESULT=`git grep -E -l "$1" $($GIT rev-list --all)`

    if [ ! -n "$RESULT" ]; then
      echo "gb-grep: not found any file for $1"
      exit 1
    else
      GREV=''
      RRESULT=``

      for LINE in $RESULT
      do
        REV=${LINE/:*/}
        NAME=${LINE/*:/}

        if [ ! "$GREV" == $REV ]; then
          GREV=$REV
          DATE=`git show -s --format="%ci" $GREV`
          echo "commit $REV from $DATE"
        fi

        echo "  $NAME"
      done
    fi
  fi
fi
