# Rebasing & feature Rebasing

## 1\. git rebase

- say you have a commit tree like below:

  ```
  |
  C0 develop
  |
  |   
  C1 dev1
  | \
  |   \
  C3    C2  dev2
  dev1
  ```

  your develop branch is in `C0`, you checkout a new branch `dev1`, made a commit `C1`.<br>
  then you find something interesting(a bug maybe), made you checkout another branch `dev2`, and commit `C2`.<br>
  and the work on dev1 continues to commit `C3`. now, something disastrous happend, `dev1` branch is broken. but you still need to continue with your work on `dev2`, do the following:

  ```
  git checkout dev2
  git rebase --onto develop dev1 dev2
  ```

  what happend here is git took your changes/diff between dev1 and dev2, added them on develop, make it a new commit on dev2.

- for more detailed explaination see [git doc](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)

## 2\. problem in feature releasing

- #### situation:

  in our new feature-develop lifecircle, say we have the following branches:

  ```
  |
  C0 develop
  | \
  |   \
  C1    C2  feature2
  feature1
  ```

  we now want to put those two features into releasing:

  ```
  git checkout feature1
  git merge develop
  git checkout feature2
  git merge develop
  git checkout develop
  git merge --no-ff feature1
  git merge --no-ff feature2
  ```

  then we made minor patches on develop:

  ```
  git commit -a -m 'fix feature1: lalala'
  git commit -a -m 'fix feature2: hahaha'
  git commit -a -m 'fix feature2: dududu'
  git commit -a -m 'fix feature1: hehehe'
  ```

  and, we found something seriously wrong with `feature2`, we need to reset our develop branch, but still keep our patches made on develop.

- #### solution:

  1. rebase feature branches
  2. reset develop branch
  3. back to local-test

## 3\. feature develop rebasing

- rebase changes on develop onto feature branch

  1. `git checkout feature/1`
  2. `git merge develop`
  3. `git rebase -i #hash-before-merging-features`
  4. pick commits you want to keep in feature/1
  5. finish rebase

- reset develop

  1. `git reset --hard #hash-before-merging-features`

- example to resolve the problem in previous section:

  1. `git checkout feature1`
  2. `git merge develop`
  3. `git rebase -i #hash-before-merging-features`, pick commits with `fix feature1`
  4. `git checkout feature2`
  5. `git merge develop`
  6. `git rebase -i #hash-before-merging-features`, pick commits with `fix feature2`
  7. `git checkout develop`
  8. `git reset --hard #hash-before-merging-features`
  9. `git push -p`
  10. reset develop stage back to local-test
