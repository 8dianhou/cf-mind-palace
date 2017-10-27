## update node nvm in local machine

  1. `nvm install v8.7.0`

  2. `nvm alias default v8.7.0`

  3. `nvm use v8.7.0`


## run app in v8.7.0

  1. `git checkout -b feature/update-node-v8.7`

  2. `rm -rf node_modules && cnpm install`

  3. remove backend babel dependence
    - in bin/www (or app.js if there's no ./bin):

      ```javascript
      // if (!process.env.NODE_ENV) require('babel-register')({
      //  	presets: ['babel-preset-node6'],
      //  	plugins: ['transform-async-to-generator'],
      //  });
      ```

    - in package.json:

      ```json
      - "babel": {
      -   "presets": [
      -     "babel-preset-node6"
      -   ],
      -   "plugins": [
      -     "transform-async-to-generator"
      -   ]
      - },

      - "babel-plugin-transform-async-to-generator": "^6.24.1",
      - "babel-preset-node6": "^11.0.0",
      - "babel-register": "^6.24.1",
      ```

    - in gulpfile.js:

      ```javascript
      // .pipe(babel({
      //   presets: ['babel-preset-node6'],
      //   plugins: ['transform-async-to-generator'],
      // }))
      ```

  3. `npm start` and wait for errors
    - `import error`:
      replace all `import ... from` in backend code with `require`

## pub test
