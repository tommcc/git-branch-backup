setup::

  $ git init ./
  Initialized empty Git repository in /tmp/cramtests-*/test.t/.git/ (glob)
  $ touch a
  $ git add a
  $ git commit -m "add a" a
  [master (root-commit) ???????] add a (glob)
   1 file changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 a
  $ touch b
  $ git add b
  $ git commit -m "add b" b
  [master ???????] add b (glob)
   1 file changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 b

test backup::

  $ for i in {1..12} ; do git branch-backup; done
  Created backup branch 'master.backup/1'
  Created backup branch 'master.backup/2'
  Created backup branch 'master.backup/3'
  Created backup branch 'master.backup/4'
  Created backup branch 'master.backup/5'
  Created backup branch 'master.backup/6'
  Created backup branch 'master.backup/7'
  Created backup branch 'master.backup/8'
  Created backup branch 'master.backup/9'
  Created backup branch 'master.backup/10'
  Created backup branch 'master.backup/11'
  Created backup branch 'master.backup/12'

  $ git branch
  * master
    master.backup/1
    master.backup/10
    master.backup/11
    master.backup/12
    master.backup/2
    master.backup/3
    master.backup/4
    master.backup/5
    master.backup/6
    master.backup/7
    master.backup/8
    master.backup/9

test hole::

  $ git branch master.backup/20
  $ git branch-backup
  Created backup branch 'master.backup/21'

test no branch on HEAD::

  $ git checkout -q HEAD~1
  $ git branch-backup
  There is no branch on HEAD
  [1]

test already on backup branch::

  $ git checkout master.backup/11
  Previous HEAD position was ???????* add a (glob)
  Switched to branch 'master.backup/11'

  $ git branch-backup
  HEAD is already a backup
  [1]

slash in branch name

  $ git checkout -b foo/bar
  Switched to a new branch 'foo/bar'
  $ git branch-backup
  Created backup branch 'foo/bar.backup/1'

BACKUP_BRANCH_FMT::

  $ export BACKUP_BRANCH_FMT='dev/%1$s/%2$s'
  $ git branch-backup
  Created backup branch 'dev/foo/bar/1'
  $ git branch-backup
  Created backup branch 'dev/foo/bar/2'

  $ git checkout -q dev/foo/bar/2
  $ git branch-backup
  HEAD is already a backup
  [1]
