#!/bin/bash

git branch -vv
git ls-remote
git status -sb
git diff master..origin/master^
git rev-list master..origin/master^
git rev-list --left-right --count master..origin/master^
git rev-list --left-right --count origin/master...@
git rev-parse --git-dir
git rev-parse --show-toplevel
git checkout -- file
git checkout v1.2.3 -- file
git checkout HEAD -- file

# forking
git remote add upstream https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY.git
git fetch upstream
git checkout master
git merge upstream/master

# clean .gitignored files from repository
git rm -r --cached .
git add .
git commit -m "removing files in .gitignore"

# remove local untracked files from current branch
git clean -fd # directories
git clean -fX # ignored files
git clean -fx # ignored files and directories

# merge from a remote pull request
git fetch https://github.com/<author>/<repo> pull/159/head:<branch-name>
git merge <branch-name>

# in package.json, reference forked repos or specific commits by
# still might have to manually build "npm install"
"repo-name" : "https://github.com/<username>/<repo-name>/tarball/master"
"repo-name" : "https://github.com/<username>/<repo-name>/tarball/<commit>"

# Temporarily switch to a different commit
# If you want to temporarily go back to it, fool around, then come back to where you are, all you have to do is check out the desired commit:
# This will detach your HEAD, that is, leave you with no branch checked out:
git checkout 0d1d7fc32
# Or if you want to make commits while you're there, go ahead and make a new branch while you're at it:

git checkout -b old-state 0d1d7fc32
#To go back to where you were, just check out the branch you were on again. (If you've made changes, as always when switching branches, you'll have to deal with them as appropriate. You could reset to throw them away; you could stash, checkout, stash pop to take them with you; you could commit them to a branch there if you want a branch there.)

# Hard delete unpublished commits
# If, on the other hand, you want to really get rid of everything you've done since then, there are two possibilities. One, if you haven't published any of these commits, simply reset:
# This will destroy any local modifications.
# Don't do it if you have uncommitted work you want to keep.
git reset --hard 0d1d7fc32

# Alternatively, if there's work to keep:
git stash
git reset --hard 0d1d7fc32
git stash pop
# This saves the modifications, then reapplies that patch after resetting.
# You could get merge conflicts, if you've modified things which were
# changed since the commit you reset to.
# If you mess up, you've already thrown away your local changes, but you can at least get back to where you were before by resetting again.

# Undo published commits with new commits
# On the other hand, if you've published the work, you probably don't want to reset the branch, since that's effectively rewriting history. In that case, you could indeed revert the commits. With Git, revert has a very specific meaning: create a commit with the reverse patch to cancel it out. This way you don't rewrite any history.
# This will create three separate revert commits:
git revert a867b4af 25eee4ca 0766c053

# It also takes ranges. This will revert the last two commits:
git revert HEAD~2..HEAD

# Reverting a merge commit
git revert -m 1 <merge_commit_sha>

# To get just one, you could use `rebase -i` to squash them afterwards
# Or, you could do it manually (be sure to do this at top level of the repo)
# get your index and work tree into the desired state, without changing HEAD:
git checkout 0d1d7fc32 .
git commit

# outputting log information
# pretty format | oneline, short, medium, full, fuller, email, raw, format:
# format: %H hash, %h abbv. hash, %an author name, %ae author email, %ad author date, (committer) %ce, %cn, %cd, %s subject, %b body, %n new line
# --numstat | --stat || --shortstat
# --date=(relative|local|default|iso|rfc|short|raw)
git log --pretty=format:"%ad - %an: %s" --after="2016-01-31" --until="2017-03-10" --author="John Doe"
git log --numstat --pretty="%H" --author="Your Name" commit1..commit2 | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}'
git log --date="short" --pretty="format:%ad (%aD) - %an: %s" --since="2018-02-01" --until="2018-03-01" --shortstat

# get total added / removed lines
git log --pretty=tformat: --after="2018-02-01" --until="2018-03-01" --numstat  | awk -F" " '{ added += $1; removed += $2 } END { print "added: ",  added, "removed:", removed }'

# git stats
apt-get install gitstats
git clone git://github.com/hoxu/gitstats.git

# create/delete repo through API
curl -u 'njhoffman:password' https://api.github.com/user/repos -d '{"name":"testing2"}'
curl -XDELETE -u 'njhoffman:password' https://api.github.com/repos/njhoffman/testing2

# speed git up
git config --global status.showUntrackedFiles no (all/normal)
git config --global core.untrackedcache true
git config --global core.preloadIndex true
git config --global index.threads true
git update-index --untracked-cache
git update-index --split-index
git update-index --assume-unchanged <trees to skip>
git gc
git clean
git remote prune origin
git count-objects -v # git count objects

