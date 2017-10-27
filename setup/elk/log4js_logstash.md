# push logs to logstash using log4js redis appender

## config/test.json

```json
{
  "log4js": {
    "appenders": {
      "out": {
        "type": "stdout"
      },
      "redis": {
        "host": "$your_host",
        "pass": "$your_pass",
        "type": "redis",
        "channel": "logs",
        "layout": {
          "type": "json_logstash"
        }
      }
    },
    "categories": {
      "default": {
        "appenders": ["out", "redis"],
        "level": "debug"
      },
      "access": {
        "appenders": ["out", "redis"],
        "level": "info"
      }
    },
    "pm2": true
  }
}
```

## utils/logger
```javascript
const logConfig = require('config').log4js;
const log4js = require('log4js');

const hostname = require('os').hostname();
const app = require('../package.json').name;

const log = console.log;

log4js.addLayout('json_logstash', () => (e) => {
  const data = e.data.join(' ').split(' ');
  const lg = {
    app,
    hostname,
    env: process.env.NODE_ENV,
    level: e.level.levelStr,
    category: e.categoryName,
    message: e.data.join('::'),
  };
  if (lg.category === 'access') {
    Object.assign(lg, {
      clientIP: data[0],
      method: data[1],
      url: data[2],
      timing: Number(data[3]),
    });
  }
  return JSON.stringify(lg);
});

log4js.configure(logConfig);

const logger = log4js.getLogger('console');
console.log = logger.info.bind(logger);
console.debug = logger.debug.bind(logger);
console.error = logger.error.bind(logger);

module.exports = category => log4js.getLogger(category);

```
