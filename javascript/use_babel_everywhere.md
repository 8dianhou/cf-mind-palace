# in development

### back-end: [babel-register](https://babeljs.io/docs/usage/babel-register/)

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
    ```

### front-end: [webpack --watch](https://webpack.js.org/configuration/)

  - install module dependences:

    ```
    cnpm i --save-dev webpack babel-loader
    ```

  - configuration, in `webpack.config.js`:

    ```javascript
    const path = require('path');

    module.exports = {
      entry: {
        'app-main': './public/app/modules/app/index.js',
        'auth-main': './public/app/modules/auth/index.js',
      },
      output: {
        path: path.resolve(__dirname, 'public/dist'),
        filename: 'scripts/[name].js',
      },
      devtool: 'source-map', // for debugging
      module: {
        rules: [{
          test: /\.js$/,
          exclude: [
            path.resolve(__dirname, 'public/bower_components'),
            path.resolve(__dirname, 'public/vendors'),
          ],
          loader: 'babel-loader',
          options: {
            presets: ['es2015']
          },
        }]
      },
    };

    ```
  - add webpack entry
    - in `public/app/modules/app/index.js`:

    ```javascript
    import 'babel-polyfill';

    import '../../../app/modules/app/main';
    import '../../../app/modules/app/routes';
    import '../../../app/config';
    '...'
    ```

    - in `views/app.ejs`:

    ```html
    <script src="/dist/scripts/app-main.js"></script>
    ```

  - start script(`package.json`):

  ```javascript
  "start": "webpack --watch & nodemon bin/www",
  ```


# in production

### back-end: [gulp-babel](https://www.npmjs.com/package/gulp-babel)

  - install module dependences:

    ```
    cnpm i --save gulp-babel babel-preset-node6 babel-plugin-transform-async-to-generator
    ```

  - in `gulpfile.js`:

    ```javascript
    const babel = require('gulp-babel');

    gulp.task('build-server', ['copy-to-server'], () =>
      gulp.src([
        'bin/www',
        'app.js',
        'middlewares/**/*.js',
        '...' // all server side scripts
      ], {
        base: '.',
      })
      .pipe(babel({
        presets: ['babel-preset-node6'],
        plugins: ['transform-async-to-generator'],
      }))
      .pipe(gulp.dest('.server/')));

    gulp.task('copy-to-server', () =>
      gulp.src([
        'config/**/*',
        'logs/**/*',
        '!logs/**/*.log',
        '...' // all files needed on server
      ], {
        base: '.',
      })
      .pipe(gulp.dest('.server/')));
    ```

### front-end: [webpack](https://webpack.js.org/configuration/)
  - pub scripts(`package.json`):

    ```javascript
    "pub-local-test": "cnpm install && bower install && npm run build && cd .server && NODE_ENV=local-test nodemon bin/www",

    "build": "webpack && gulp clean && gulp dist && gulp build && gulp rev && gulp pub-static && npm run build-server",

    "build-server": "gulp build-server"
    ```

  - deploy script(`deploy.sh`):
    ```bash

    cd .server
    tar -zcf ~/${FILE} ./
    ```
