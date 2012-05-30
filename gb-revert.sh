#!/bin/bash

DIR=`pwd`

GIT=/usr/bin/git
GB="`dirname $0`/gb.sh"

if [ ! -e "$DIR/.git" ]; then
  echo "gb-revert: not in git repository."
  exit 1
else
  if [ ! -n "$1" ]; then
    echo "gb-revert: add filename you want to revert."
    exit 1
  else
    $GIT log --stat --pretty="format:%h on %s, changes: " $1

    file_rev='qwerrtyu'
    until $GIT branch -a --contains $file_rev &> /dev/null ; do
      echo -n "Which revision? "
      read file_rev
    done

    cp -r $1 "$1.current_backup"
    echo "gb-revert: made backup to $1.current_backup"

    $GIT checkout $file_rev $1
    echo "gb-revert: file $1 reverted."
  fi
fi
