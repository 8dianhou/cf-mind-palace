### [Specifics on CSS Specificity](https://css-tricks.com/specifics-on-css-specificity/)
[https://css-tricks.com/specifics-on-css-specificity/](https://css-tricks.com/specifics-on-css-specificity/)

#### summary:
Form my understanding, css specificity contains 4 levels:
* element tag is lv1: 0,0,0,__1__
* class/psuedo-class/attr is lv2: 0,0,__1__,0
* ID is lv3: 0,__1__,0,0
* inline style is lv4: __1__,0,0,0

__notice__
* a number in a higher level **always** outweighs a number in a lower level, e.g., 0,__1__,0,0 outweighs 0,0,__999__,0
* ```!important``` is like a whole other level (consider __1__,0,0,0,0 or *like the Jedi mind trick for CSS* as in the original article) .
* The ```:not()``` sort-of-pseudo-class adds no specificity by itself, only what's inside the parens is added to specificity value.

multiple occurrence only adds the number for one certain level, see example below:
![](https://css-tricks.com/wp-content/csstricks-uploads/cssspecificity-calc-1.png)
![](https://cdn.css-tricks.com/wp-content/uploads/2010/05/cssspecificity-calc-3v2.jpg)
![](https://css-tricks.com/wp-content/csstricks-uploads/cssspecificity-calc-4.png)
