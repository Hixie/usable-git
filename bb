#!/bin/bash
set -e

if [[ `git status --porcelain` ]]; then
  echo 'Your branch has uncommitted changes. Use "commit" or "clean" first.'
  exit 1
fi

git checkout $1
pull
d
