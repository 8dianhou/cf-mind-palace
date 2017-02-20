# Develop lifecircle


  1. checkout new feature branches from develop:
    `develop is in stable`

    ```
    git checkout -b feature/1
    git checkout -b ...
    ```

  2. do your things on feature branches

  3. do a **thorough local-test** on feature branches:

    ```
    npm run pub-local-test
    ```

  4. create pull requests for review:
    `develop is in stable`

    ```
    git merge develop
    ```

  5. release owner merge pulls and pub-test:
    `do not merge on github`

    ```
    git merge --no-ff feature/1
    git merge --no-ff ...
    npm run pub-test
    ```

  6. test the whole thing, when bug appears:

    - if minor: do small patches on develop.
      add commit message like `fix feature/1: ...`
    - if else: see **rebasing_in_feature_develop.md**.

  7. when ready, merge to master and publish:

    ```
    git checkout master
    git merge --no-ff develop
    git push
    npm run pub-prod
    ```

  8. for new features, checkout new feature branches from develop
