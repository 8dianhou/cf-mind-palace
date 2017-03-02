# Code Style Rule

## Formatting

### 2 Spaces for indentation

Use 2 spaces for indenting your code and swear an oath to never mix tabs and spaces - a special kind of hell is awaiting you otherwise.

### Semicolons are compulsory

*Right:*
```javascript
if (1) {
  console.log(1);
}
```

### Single statement

*Right:*
```javascript
var foo = 0;
var foo1 = 1;
```

### Use single quotes

Use single quotes, unless you are writing JSON.

*Right:*
```javascript
var foo = 'bar';
```

### Opening braces go on the same line

*Right:*
```javascript
if (true) {
  console.log('winning');
}
```

## Naming Conventions
### Use lowerCamelCase for variables, properties and function names

*Right:*
```javascript
var adminUser = db.query('SELECT * FROM users ...');
```

### Use UpperCamelCase for class names

*Right:*
```javascript
var Foo = class {
  constructor() {}
  bar() {
    return "Hello World!";
  }
};
```

### Use UPPERCASE for Constants
Constants should be declared as regular variables or static class properties, using all uppercase letters.

*Right:*
```javascript
var SECOND = 1 * 1000;

function File() {
}
File.FULL_PERMISSIONS = 0777;
```

## Variables

### Object / Array creation

*Right:*
```javascript
var a = ['hello', 'world'];
or
var a = [
  'hello',
  'world'
];
var b = {
  good: 'code',
  'is generally': 'pretty',
};
```

## Conditionals

### Use the === operator

*Right:*
```javascript
var a = 0;
if (a === '') {
  console.log('losing');
}
```

## Functions

### No nested closures

Use closures, but don't nest them. Otherwise your code will become a mess.

*Right:*
```javascript
setTimeout(function() {
  client.connect(afterConnect);
}, 1000);

function afterConnect() {
  console.log('winning');
}
```

### Method chaining

You should indent these methods so it's easier to tell they are part of the same chain.

*Right:*
```javascript
models.Student.findById(id)
  .then(function(student) {
    var params = {};
    return student.update(params);
  })
  .then(function(result) {

  })
  .catch(function(error) {

  })
```
