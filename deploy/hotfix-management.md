## hotfix management

### 1. New hotfix branch

  ```

    git checkout develop

    git pull

    git checkout master

    git pull

    make sure the tagName is the latest

    git checkout -b ${hotfixBranchName}

    git push

    git push -up ...

  ```

### 2. Pub hotfix branch

  ```

    git checkout ${hotfixBranchName}

    git pull

    git checkout master

    git pull

    git merge --no-ff ${hotfixBranchName}

    git push

    npm run pub-prod

    if you need to run scripts please to backup the database

    ssh cf-prod@139.196.197.99(assessment项目：ssh assessment-prod@106.15.35.30)

    node ${jsFileName} (according to the checklist.md)

    mysql -u cfdev -p ${tableName}(admin:cfdb/assessment:assessment)

    source ${sqlFileName} (according to the checklist.md)

    exit to local

    git tag v1.1.xx -a & write release notes(like 2017-03-23:hotfix 更新图片)

    git push origin v1.1.xx

    git checkout develop

    git merge —no-ff ${hotfixBranchName}

    git push

  ```
