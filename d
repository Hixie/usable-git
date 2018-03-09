#!/bin/bash
set -e

if (git remote | grep --fixed-strings --line-regexp --quiet 'upstream') then
  git diff upstream/master --stat $@
  git diff --check upstream/master $@
  git diff --find-copies-harder --ignore-space-change --inter-hunk-context=10 --color --unified=10 upstream/master $@
else
  git diff origin/master --stat $@
  git diff --check origin/master $@
  git diff --find-copies-harder --ignore-space-change --inter-hunk-context=10 --color --unified=10 origin/master $@
fi
