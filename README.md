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


`logs`

  Show recent commits in one line each, with relative time and author.


`new foo`

  Create a branch `foo`.


`d`

  Show the combined diff of the commits on the current branch that are not on
  upstream/main. When there is no remote named upstream, compare with
  origin/main instead. The main branch name comes from `$MAIN` when that is
  set.


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

  Rebase the current branch onto the latest main branch, then send it to
  GitHub. If the rebase has merge conflicts, abort it and do not push.
  When the server replies with a page for opening a pull request, that
  page is opened in your browser.


`publish`

  Rebase the current branch onto `origin/main`, then push it to
  `origin/main`. The main branch name comes from `$MAIN` when that is set.
  Repositories with an `upstream` remote are rejected.


`n bar`

  Rename the current branch to `bar`.


`bb main`

  Switch to the `main` branch and pull changes.


`b bar`

  Switch to the `bar` branch without pulling changes.


`pull`

  Rebase the current branch onto the latest main branch. If the rebase has
  merge conflicts, abort it.


`fix quux.dart`

  Run emacsclient on quux.dart to fix merge conflicts.


`forget`

  Throw away local changes since last commit/amend.


`revert quux.dart baz.dart`

  Throw away local changes vs upstream.


`prwatch`

  Watch the pull request for the current branch and print one line per
  thing that happens to it, until it settles. Reports failing checks as
  they land, workflow runs as they finish, every comment (issue-level,
  inline, and review summaries), and every review thread as it opens or
  is resolved. Takes a pull request number, a URL, or `owner/repo#N`
  instead, if you do not want the one for this branch.

  A few things it is careful about, because watchers usually are not. A
  pull request whose checks have not registered yet is not called green.
  A commit that a newer push has replaced is announced as a retarget
  rather than reported as thirty failures. A failed request to GitHub
  updates nothing, so a network blip cannot look like every comment
  being deleted, and the poll after a blip has nothing to re-announce. A
  reading it could not take is printed as `?`, never as `0`. A head that
  no reviewer has reached is counted and said out loud, since a review
  that found nothing leaves no comment and no thread behind it, and
  would otherwise be indistinguishable from a review that never
  happened. And it says something on a schedule even when nothing has
  changed, so silence never has to be interpreted.

  `prwatch 6677 --once` prints where things stand and exits.
  `prwatch 6677 --expect HEAD` also checks that the commit you have
  checked out is the one the pull request points at, which catches a
  push that went somewhere else.

  `prwatch --help` carries the whole guide: the remaining options,
  what each event tag and each verdict means, and how to run it from
  an agent. Point people and agents at that rather than at this file.
  `prwatch-test` drives the paths a green pull request never reaches,
  against made-up data and no network; run it after changing `prwatch`.


`nuke`

  Delete the current branch.


`armageddon`

  Blow everything away and reset back to a pristine copy of upstream.
  Removes all worktree debris, deletes every local branch (including
  main, but keeping branches checked out in linked worktrees), empties
  the stash, recreates main tracking upstream/main, and force-pushes
  your fork's main to match upstream's main. Inside a linked worktree,
  destroys only that worktree: wipes it clean, deletes the branch it had
  checked out, and leaves it detached at upstream/main, keeping other
  branches, the stash, and your fork untouched. Asks for confirmation
  first (type "armageddon"), or pass `-y` to skip the prompt. Plays a particle-based cluster-bomb barrage across the whole
  terminal while the work's output scrolls up through it; your earlier
  console contents scroll up into scrollback, and the work's output is
  left on screen when it finishes. The barrage runs for two seconds past
  the work; pass `--fast` to stop it the moment the work does, or
  `--no-color` to skip the animation entirely.

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
