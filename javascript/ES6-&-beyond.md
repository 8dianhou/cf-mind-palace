## [learn-es2015](https://babeljs.io/docs/learn-es2015/)
summary:
* es2015 makes a better world.
* es2015 is not _'new'_ anymore, it's a promising future.
* nodejs v6 supports most of es2015 new features, and **v6 is LTSing** soon
* for front end compatibility, we have babel.js


why keep writing code like:
```javascript
for(var i = 0; i < list.length; i++){// wtf?
  var item = list[i];// finally!
}
```
when we can simply do:
```javascript
for(var item in list){
}
```
...and it gets better:
```javascript
for(var key of obj){
}
```
[read more](https://babeljs.io/docs/learn-es2015/)
.</br>
.</br>
.</br>
.</br>
.</br>
.</br>
.</br>
harsh truth:</br>
nodejs v4 only supports <span style="color: red">~50%</span> of es2015 features</br></br> **BUT** nodejs v6 already have <span style="color: green">90%+</span> coverage. **and nodejs v6 is gonna hit LTS start** later this year(2016-10-01), so get pumped, we can consider nodejs v6 for our next project.
