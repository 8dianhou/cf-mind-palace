## pub-test 流程

### 1. Release Notes

  - [ ] release projects & branches  
  - [ ] release notes
  - [ ] pub test date
  - [ ] pub project sequence

### 2. Pull Request

  - [ ] reviewer comment "ready for merge"
  - [ ] pull request has no "help wanted" label

### 3. Pub Test

  ```
  git checkout develop  

  git pull  

  git checkout origin/${branchName}

  git merge develop

  git push

  repeat above 3 commands, until all pull requests merged from develop

  git checkout develop

  git merge --no-ff ${branchName}

  git push

  repeat above 2 commands, until all pull requests merged into develop

  if conflict happened, solve conflicts first
  
  sync prod database 
  
  npm run pub-test

  ssh cf-test@139.196.193.120

  cd apps/${projectName}

  node ${jsFileName}

  mysql -u cfdev -p ${tableName}(admin:cfdb/assessment:assessment)

  source ${sqlFileName}

  exit

  exit

  make sure that all branch workers checkout to develop
  ```

### 4. Ending

  ```
  if (all branches ready to pub prod) {
    goto 4.1
  } else {
    goto 4.2
  }
  ```
  #### 4.1 goto pub-prod.md

  #### 4.2 rebase

    
