### var title = undefined

#### Arrow function expression

`reference`: [ES6 你可能不知道的事 - 基础篇](http://taobaofed.org/blog/2016/07/22/es6-basics/)
```javascript
var arr = () => arguments;
var arr = () => { return arguments; };
var arr = (param1, param2) => { return arguments; };
```
to make promises cleaner:

```javascript
gitPromise
  .then(() => git.add())
  .then(() => git.commit())
  .then(() => git.log())
  .then((msg) => {
      ...
  })
  .then(() => git.push())
  .catch((err) => {
      utils.error(err);
  });
```
`this` and `arguments`: they both reference the parent scope.



#### Array and Object manipulation

 `reference`: [Array.prototype.sort()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort)
```javascript
arr.sort(compare);

function compare(a, b) {
  if (a is less than b by some ordering criterion) {
    return -1;
  }
  if (a is greater than b by the ordering criterion) {
    return 1;
  }
  // a must be equal to b
  return 0;
}
```
with some 'decipher', it sums up to this:</br>
`return 1` will put `a` behind `b`, period.

#### Object copying

```javascript
var newObj = Object.assign({}, oldObj);
```

#### Map-Reduce
```javascript
var animals = ["cat","dog","fish"];
var lengths = animals.map(animal => animal.length);
console.log(lengths); //[3, 3, 4]

var totalLength = lengths.reduce((current, next) => current + next);
console.log(totalLength); //10
```
>Think a problem like this:

>    S = 1 + 1*2 + 1*2*3 + ... + n! ?

solution can be like this:

```javascript
function Range(n) {
  return Array.apply(null, Array(n)).map((val, i) => i + 1);
}

function getSum(n) {
  var range = Range(n);
  return range.map((val, i) => getFa(i + 1))
  .reduce((pre, cur) => pre + cur);
}

function getFa(n) {
  var range = Range(n);
  return range.reduce((pre, cur) => pre * cur);
}
console.log(getSum(4));// 33

```


#### Execute a list of promise in order
```javascript
return getCourseSchedules(courseScheduleIds)
.then(function(courseSchedules) {
  var len = courseSchedules.length;
  var i = 0;
  return nextCS();
  function nextCS() {
    if(i < len){// exec promises in order
      return fillCourseSchedule(courseSchedules[i]).then(function(){
        i++;
        return nextCS();
      });
    }
  }
});
```

#### Closure
```javascript
'use strict';
const closure = () => {
  let flag = false;

  function doSth() {
    flag = !flag;
    console.log(flag);
  }

  function doSth2() {
    flag = false;
    console.log(flag);
  }
  return {
    doSth,
    doSth2
  };
}();
closure.doSth();
closure.doSth2();
```
>It's like `private` in js( and instance of a anonymous class).

#### High order functions
```javascript
'use strict';
function closureCounter(initCount, step) {
  return {
    next: function() {
      return initCount += step
    }
  }
};
var counter = closureCounter(4, 3);
console.log(counter.next());// 7
```

#### Discussion: code block style </br>
to avoid getting a load of c**p, at first, i thought we can do this:
```javascript
(function joinStudentTimetable() {
  var dayOfWeek = ...;
  var startTime = ...;
  var endTime = ...;

  var StudentTimetable = {
    //...
  };
  includeCondition.push(StudentTimetable);
})();
```
then, after some discovering, i changed it to:
```javascript
includeCondition.push(joinScheduletag(scheduletagIds));
includeCondition.push(joinCourseSchedule(courseScheduleId, scheduleStartDate));
includeCondition.push(joinStudentTimetable(scheduleStartDate));

function joinStudentTimetable(scheduleStartDate) {
  var dayOfWeek = ...;
  var startTime = ...;
  var endTime = ...);

  var StudentTimetable = {

  };
  return StudentTimetable;
};
```
The idea is to '_make sense_', `function`s should take input & output, and it should be independent as no out-of-context variable should be used;
