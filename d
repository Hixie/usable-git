set -e
git diff upstream/master --stat $@
git diff --check upstream/master $@
git diff --find-copies-harder --ignore-space-change --inter-hunk-context=10 --color --unified=10 upstream/master $@
