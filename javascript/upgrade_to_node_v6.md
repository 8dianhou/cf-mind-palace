# main
  1. install nvm

    ```bash
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
    ```

  2. install v6-lts

    - first list the newest of lts: `nvm ls-remote --lts`

    - find the latest lts(in this case, `v6.10.0 (Latest LTS: Boron)`)

    - install `nvm install v6.10.0`, after installation, set default by running `nvm alias default v6.10.0`.

  3. upgrade node_modules **on server**

    `rm -r node_modules && cnpm i`

  4. restart app

    `pm2 restart appId`

# extra setups
  > to get the most out of the new features

  <!-- 1. [babel-register](https://babeljs.io/docs/usage/babel-register/)

    - install module dependences:

      ```
      cnpm i --save babel-register babel-preset-node6 babel-plugin-transform-async-to-generator
      ```

    - in `app.js`, add the following line at the top:

      ```javascript
      require('babel-register')({
        presets: ['babel-preset-node6'],
        plugins: ['transform-async-to-generator']
      });
      ``` -->
  2. eslint

    - why
      - jshint dont support es7 syntax!
      - [A mostly reasonable approach to JavaScript](https://github.com/airbnb/javascript)(Airbnb)

    - install
      atom package linter-eslint
      ```
      cnpm i -g eslint eslint-plugin-import eslint-config-airbnb-base
      cnpm i --save-dev eslint eslint-plugin-import eslint-config-airbnb-base
      ```

    - .eslintrc.js

      ```javascript
        module.exports = {
          env: {
            browser: true,
          },
          extends: 'airbnb-base',
          plugins: [
            'import'
          ],
          rules: {
            'padded-blocks': ['warn'],
            'no-use-before-define': ['error', { 'functions': false}],
            'no-param-reassign': ['error', { 'props': false }],
            'no-dynamic-require': 0,
            'no-plusplus': 0,
          },
        };
      ```

  3. pre-commit(**optional**)

    ```bash
    #!/bin/bash

    git stash -q --keep-index

    git diff-index --cached HEAD --name-only --diff-filter ACMR | egrep '\.js$' | xargs $(npm bin)/eslint
    RESULT=$?

    git stash pop -q

    [ $RESULT -ne 0 ] && exit 1

    git pull
    RES=$?

    [ $RES -ne 0 ] && exit 1

    exit 0
    ```

# fallback strategy
  - nvm has a special default alias "system"

  ```
  nvm use system
  rm -r node_modules && cnpm i
  pm2 restart
  ```
