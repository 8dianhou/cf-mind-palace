
#### `let` vs `var`:
`reference`: [Syntax reference on MDN](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/let)

```javascript
function varTest() {
  var x = 1;
  if (true) {
    var x = 2;  // same variable!
    console.log(x);  // 2
  }
  console.log(x);  // 2
}

function letTest() {
  let x = 1;
  if (true) {
    let x = 2;  // different variable
    console.log(x);  // 2
  }
  console.log(x);  // 1
}
```

```javascript
'use strict';

for(var i of ['a', 'b', 'c']) {
  i+='1';
}

for(let a of ['a', 'b', 'c']) {
  a++;
}

console.log('i: ', i);// i: c1
console.log('a: ', a);// a is not defined
```

>_and how is that gonna be of any use?_

```javascript
'use strict';

for(var i of ['a', 'b', 'c']) {
  Promise.resolve(1).then(() => {
    setTimeout(() => {
      console.log('i: ', i);
    }, 100)
  })
}
// i:  c
// i:  c
// i:  c

for(let i of ['a', 'b', 'c']) {
  Promise.resolve(1).then(() => {
    setTimeout(() => {
      console.log('i: ', i);
    }, 100)
  })
}
// i:  a
// i:  b
// i:  c
```
_dissect:_ `let` is like :

```javascript
for(let item of things)
//equals to
for(var i = 0; i...) {
  var item = things[i];
}

//while
for(var item of things)
//equals to
var item;
var i = 0;
while(i < things.length) {
  item = things[i];
  // do whatcha gonna do
  i++;
}

for(var i = 0, item = things[0]; i < things.length; item = things[++i])
// !item will be undefined after loop
```

#### `const`:
[The const declaration creates a read-only reference to a value. It does not mean the value it holds is immutable, just that the variable identifier cannot be reassigned.](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/const)

**conclusion:**
1. use `let` if there's async operation in the loop.
2. use `let` to avoid mistakenly changing the value of the variable of the same name in the parent context.

>I don’t use `var` in ES6. There is value in block scope for loops, but I can’t think of a situation where I’d prefer `var` over `let`.

>`const` is a signal that the identifier won’t be reassigned.

>`let`, is a signal that the variable may be reassigned, such as a counter in a loop, or a value swap in an algorithm. It also signals that the variable will be used only in the block it’s defined in, which is not always the entire containing function.

>`var` is now the weakest signal available when you define a variable in JavaScript. The variable may or may not be reassigned, and the variable may or may not be used for an entire function, or just for the purpose of a block or loop.

>[JavaScript ES6+: var, let, or const?](https://medium.com/javascript-scene/javascript-es6-var-let-or-const-ba58b8dcde75#.lbdcz8etw)
