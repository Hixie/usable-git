set -e

if [[ `git status --porcelain` ]]; then
  echo 'Your branch has uncommitted changes. Use "commit" first.'
  exit 1
fi

git checkout $1
