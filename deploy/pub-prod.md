## Pub Prod 流程

### 1. Backup Database

  ```
    ssh cf-prod

    cd ~/backup

    mysqldump -u cfdev -p cfdb | gzip -c > cfdb-prod_2017-01-13.sql.gz;

    scp cfdb-prod_2017-01-13.sql.gz cf-test@139.196.193.120:~/backup

    exit
  ```

### 2. Pub Projects & Tag

  ```
    git checkout develop

    git pull

    git checkout master

    git pull

    git merge --no-ff develop

    git push

    npm run pub-prod

    ssh cf-prod

    run scripts(.js .sql) according to the checklist.md

    exit to local

    git tag v1.xx.0 -a & write release notes

    git push origin v1.xx.0

    git checkout develop

  ```
