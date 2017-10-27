## init server

#### 1. init repo
ssh into server, then:

```bash
cd ~/deploy
git clone https://$GIT_REPO --bare
```

`GIT_REPO`: your github repo url

> use `git config --bool core.bare true` for existing ones

#### 2. add post-receive hook
[more details about git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- `vim .git/hooks/post-receive`
- fill the content with following:
  ```bash
  #!/bin/bash
  BRANCH=test
  WORK_TREE=../run

  while read oldrev newrev ref
  do
      if [[ $ref =~ .*/$BRANCH$ ]]; then
          echo "ref $ref received.  Deploying master branch to $HOSTNAME..."

          mkdir -p $WORK_TREE
          git --work-tree=$WORK_TREE --git-dir=$GIT_DIR checkout -f $BRANCH
          cd $WORK_TREE
          # do your deploy work here

          echo "Git hooks deploy complete."
      else
          echo "Ref $ref successfully received.  Doing nothing: only the master branch may be deployed on this server."
      fi
  done
  ```
- set hook permission `chmod -R 777 .git/hooks`

> **our customized post-receive script are inside the project repo**

## init local

#### 1. set git remote

in local git repo:

```bash
git remote add $REMOTE_NAME $USER@$REMOTE_IP:$REPO_DIR
```
`REMOTE_NAME`: git this remote a name

`USER`&`REMOTE_IP`: logon of server, add your ssh keys first

`REPO_DIR`: location of remote repository

#### 2. push to remote

```bash
git push $REMOTE_NAME $BRANCH
```
then see the remote feedback by post-receive hook

#### \*3 modify deploy script (cf project specific)
ref: setup/deploy/scripts.md
