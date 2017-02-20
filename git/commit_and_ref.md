
## Git refs explained

  - ### what is a commit

    in `git log`, we see all our commits listed like the following:

    ```
    commit a21a1f2b731ae3b561def9c285e1949af13a581c
    Merge: e2ae329 87798d1
    Author: jasonz <zyol@outlook.com>
    Date:   Fri Feb 10 11:42:46 2017 +0800

        Merge branch 'develop' of https://github.com/8dianhou/cf-client into develop

    commit e2ae329bc0f80f51f13432880ab3c5728828b53d
    Author: jasonz <zyol@outlook.com>
    Date:   Fri Feb 10 11:42:07 2017 +0800

        config location & route

    commit 87798d17bb024ba3e8f96118cad1ad4bf9207f36
    Author: tanyvonne <tanyunshuang@sudaotech.com>
    Date:   Fri Feb 10 11:17:20 2017 +0800

        style fixed for gender block
    ```
    It looks like commit0(_`a21a1f`, by jasonz_) comes from commit1(_`e2ae32`, by jasonz_), which comes from  commit2(_`e2ae32`, by tanyvonne_), as least I thought so for a long time.<br>

    But that's wrong.

    Notice that every commit comes with a 'id' like `a21a1f2b731ae3b561def9c285e1949af13a581c`, which in essence is a `sha1` hash string.
    ```
    sha1(
        meta data
        commit message
        commiter
        commit date
        author
        authoring date
        Hash-Of-Entire-Working-Directory (bear, with me!)
    )
    ```
    exclimation mark on **Hash-Of-Entire-Working-Directory!**

    Why the Entire-Working-Directory? That's because, **a commit is actually a snapshot of the project source at that time**.

  - ### how commits are related:
    ```
    G   H   I   J
     \ /     \ /
      D   E   F
       \  |  / \
        \ | /   |
         \|/    |
          B     C
           \   /
            \ /
             A
    ```
    graph ref: [stackoverflow.com](http://stackoverflow.com/questions/2221658/whats-the-difference-between-head-and-head-in-git)

    the graph above a commit hierarchy tree: <br>

      - if the HEAD is at `A`, then the working directory contains all changes from commits `A-J`
      - if the HEAD is at `B`, then the working directory contains all changes from commits `B` and `D-J`,
      - if the HEAD is at `D`, then the working directory contains all changes from commits `D` and `G-H`

    <br> That means, commits are not linear like a list, but a tree structure.
    when we run `git log` for a project with above commits `A-J`, we should a list ordered `A-C-B-F-E-D-J-I-H-G`.

    if you run `git log C(hash for commit C)`, the list is `C-F-E-J-I`.

  - ### Git References
    read the [doc](https://git-scm.com/book/en/v2/Git-Internals-Git-References).
    - ref:
      At git internal, a ref is a file containing the sha1 value of a commit, if I run `cat .git/refs/heads/develop`, I'll get `a21a1f2b731ae3b561def9c285e1949af13a581c`, which is the sha1 value of the last commit.

    - HEAD
      once you figured out what a ref is, HEAD is simple: a HEAD file refs to a ref, says what ref your current working directory is on.

    - what to get out of this
      If we read the reply from the graph ref [stackoverflow.com](http://stackoverflow.com/questions/2221658/whats-the-difference-between-head-and-head-in-git) from above, we should know that HEAD^ means the parent of current HEAD. That gives us a short cut for resetting a merge, for example:
      1. we have a feature branch and a develop branch:
      ```
        develop
            |     
            0     
             \   
              \
               1 feature
               |
               |
               2
      ```
      2. merge feature with `--no-ff`:

      ```
        develop
            |     
            0     
            | \   
            |  \
            |   1 feature
            |   |
            |   |
            |   2
            |  /
            |/
            3
      ```
      run a `git log` at this time, we'll get `3-2-1-0`

      3. If we're to do a reset, we need to find `0`, and reset with that hash, but if we run `git reset --hard HEAD^`, it will get us stright back to `0`.

      4. If we merged 2 feature branches, `git reset --hard HEAD^^` or `git reset --hard HEAD~2` will do.


  - ### conclusion
    Commits are not linear, but a tree structure, it represents the whole project at a certain time. When we resets to a commit, we headed back to where that commit happens.

    Use the example from the beginning commits. commit0(_`a21a1f`, by jasonz_), commit1(_`e2ae32`, by jasonz_), commit2(_`e2ae32`, by tanyvonne_). the should look like this:
    ```
          |     |
          1     2
           \   /
            \ /
             0
    ```
    Commit2 and several its parent commits are from a feature branch f1, if we reset to commit1, our current branch(develop) will reset to before the merge of f1 happened.
