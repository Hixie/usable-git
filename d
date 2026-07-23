#!/bin/bash

set -e

MAIN="${MAIN:-main}"

if (git remote | grep --fixed-strings --line-regexp --quiet 'upstream') then
  BASE="refs/remotes/upstream/$MAIN"
else
  BASE="refs/remotes/origin/$MAIN"
fi

if START=$(git merge-base "$BASE" HEAD); then
  :
else
  MERGE_BASE_STATUS=$?
  if [ "$MERGE_BASE_STATUS" -ne 1 ]; then
    exit "$MERGE_BASE_STATUS"
  fi
  START=$(git hash-object -t tree /dev/null)
fi

git diff --stat "$START" HEAD "$@"
git diff --minimal --find-copies-harder --ignore-space-change --inter-hunk-context=25 --color=auto --unified=50 "$START" HEAD "$@"
git diff --check "$START" HEAD "$@"
