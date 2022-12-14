set -e

MAIN="${MAIN:-main}"

if (git remote | grep --fixed-strings --line-regexp --quiet 'upstream') then
  git diff upstream/$MAIN --stat $@
  git diff --minimal --find-copies-harder --ignore-space-change --inter-hunk-context=10 --color --unified=10 upstream/$MAIN $@
  git diff --check upstream/$MAIN $@
else
  git diff origin/$MAIN --stat $@
  git diff --minimal --find-copies-harder --ignore-space-change --inter-hunk-context=10 --color --unified=10 origin/$MAIN $@
  git diff --check origin/$MAIN $@
fi
