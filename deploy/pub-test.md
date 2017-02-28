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

  git merge --no-ff origin/${branchName}

  git push

  repeat above commands, until all pull requests merged into develop

  if conflict happened, solve conflicts first

  npm run pub-test

  ssh cf-test

  run scripts(.js、.sql)

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
