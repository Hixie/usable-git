# usable-git
A bunch of shell scripts that make using git bearable.

This is for working with branches on forks of projects, not directly commiting to
a project's master. It's expected that your changes will go through the
GitHub PR process to actually end up commited to the project.

## Installation

Run the following commands in a terminal:

```bash
mkdir -p ~/bin
cd ~/bin
git clone git@github.com:Hixie/usable-git
echo 'export PATH=$PATH:~/bin/usable-git' >> ~/.bash_profile
```

Then, open a new terminal.

## Usage:

`clone flutter engine me`

  Prepares a local checkout of your fork of flutter/engine (where your
  fork is in me/engine).


`br`

  List current branches.


`new foo`

  Create a branch `foo`.


`d`

  Show a diff of your changes on the current branch.


`add quux.dart baz.dart`

  Add the local files to the repo (stage for commit).


`commit`

  Commit the current changes using emacsclient to write the commit message.


`amend`

  Update the current commit with new changes.


`push`

  Send the current branch to GitHub.


`n bar`

  Rename the current branch to `bar`.


`bb master`

  Switch to the `master` branch and pull changes.


`b bar`

  Switch to the `bar` branch without pulling changes.


`pull`

  Pull the changes from upstream.


`fix quux.dart`

  Run emacsclient on quux.dart to fix merge conflicts.


`forget`

  Throw away local changes since last commit/amend.


`revert quux.dart baz.dart`

  Throw away local changes vs upstream.


`nuke`

  Delete the current branch.
