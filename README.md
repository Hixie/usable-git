# usable-git
A bunch of shell scripts that make using git bearable.

This is for working with branches on forks of projects, not directly
commiting to a project's main branch. It's expected that your changes
will go through the GitHub PR process to actually end up commited to
the project.

## Installation

Run the following commands in a terminal:

```bash
mkdir -p ~/bin
cd ~/bin
git clone git@github.com:Hixie/usable-git
echo 'export PATH=$PATH:~/bin/usable-git' >> ~/.bash_profile
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_rsa.pub ; use the same key you use to push to GitHub
```

Then, open a new terminal.

## Other git config options you might want

```bash
# remember merge conflict fixes
git config --global rerere.enabled true
```

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


`clean`

  Show you what files would be deleted by running `git clean`, and
  gives you instructions for doing so.


`commit`

  Commit the current changes using emacsclient to write the commit message.


`amend`

  Update the current commit with new changes.


`save`

  Commit your current changes with the message "wip" and upload it to
  GitHub on your fork, merging any remote changes in as well.


`push`

  Send the current branch to GitHub.


`publish`

  Push your current main branch to your GitHub main branch.


`n bar`

  Rename the current branch to `bar`.


`bb main`

  Switch to the `main` branch and pull changes.


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

## Configuration

If you're using emacs, the following is a good start for a `~/.gitconfig` file:

```
[core]
        autocrlf = false
        filemode = false
        editor = emacsclient
[branch]
        autosetuprebase = always
[pager]
       	diff = false
        commit = false
        log = false
        cl = false
        blame = false
        merge = false
        rebase = false
        help = false
        show = false
        reflog = false
        grep = false
[push]
        default = simple
[credential]
        helper = cache --timeout=315569000
```
