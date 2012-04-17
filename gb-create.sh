#!/bin/bash

DIR=`pwd`

GIT=/usr/bin/git
GIT_REMOTE="~/backups"
GIT_DIRECTORY="$GIT_REMOTE/`echo $DIR | md5`.gb"
GB="`dirname $0`/gb.sh"

if [ -e "$DIR/.git" ]; then
  echo "gb-create: git repository already exists."
  exit 1
else
  $GIT init $DIR &> /dev/null
  echo "gb-create: created git repository."

  git_server=''

  until ping -q -c1 -t1 $git_server &> /dev/null ; do
    echo -n "What's backup server address? "
    read git_server
  done

  ssh $git_server "mkdir $GIT_REMOTE; mkdir $GIT_DIRECTORY; cd $GIT_DIRECTORY; git init --bare ." &> /dev/null
  echo "gb-create: created remote git repository."

  $GIT remote add backup "ssh://$git_server/$GIT_DIRECTORY"
  echo "gb-create: added remote git repository."

  echo "gb-create: ready to use!"

  $GB backup
fi
