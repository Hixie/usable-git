set -e

MASTER="${MASTER:-master}"

if (git remote | grep --fixed-strings --line-regexp --quiet 'upstream') then
  git diff upstream/$MASTER --stat $@
  git diff --find-copies-harder --ignore-space-change --inter-hunk-context=10 --color --unified=10 upstream/$MASTER $@
  git diff --check upstream/$MASTER $@
else
  git diff origin/$MASTER --stat $@
  git diff --find-copies-harder --ignore-space-change --inter-hunk-context=10 --color --unified=10 origin/$MASTER $@
  git diff --check origin/$MASTER $@
fi
