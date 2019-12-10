# 流程控制语句

## 分支

### if 和if-else和else if

```dart
if (isRaining()) {
  you.bringRainCoat();
} else if (isSnowing()) {
  you.wearJacket();
} else {
  car.putTopDown();
}
```

### switch 和 case

在Dart中switch语句使用 “\==”运算来比较整数，字符串或者编译时常量。被比较对象必须都是同一个类的实例(而不是它的任何子类型)，并且这个类不能重写“==”操作。枚举类型在switch语句是一种非常好的应用场景。

switch的规则是每个非空的case子句以一个break语句结束。结束非空case子句的其他有效方法是continue、throw或return语句。

当没有case子句匹配时，使用default子句执行代码:

```dart
var command = 'OPEN';
switch (command) {
  case 'CLOSED':
    executeClosed();
    break;
  case 'PENDING':
    executePending();
    break;
  case 'APPROVED':
    executeApproved();
    break;
  case 'DENIED':
    executeDenied();
    break;
  case 'OPEN':
    executeOpen();
    break;
  default:
    executeUnknown();
}
```

下面的示例省略了case子句中的break语句，从而产生错误:

```dart
var command = 'OPEN';
switch (command) {
  case 'OPEN':
    executeOpen();
    // ERROR: Missing break

  case 'CLOSED':
    executeClosed();
    break;
}
```

然而，Dart支持空的case子句,支持fall-through的格式:

```dart
var command = 'CLOSED';
switch (command) {
  case 'CLOSED': // Empty case falls through.
  case 'NOW_CLOSED':
    // 无论command是CLOSED还是NOW_CLOSED都执行
    executeNowClosed();
    break;
}
```

如果你真的需要使用fall-through格式，你可以使用continue语句和一个标签，例如：

```dart
var command = 'CLOSED';
switch (command) {
  case 'CLOSED':
    executeClosed();
    continue nowClosed;
  // 跳转至nowClosed
  nowClosed:
  case 'NOW_CLOSED':
    // Runs for both CLOSED and NOW_CLOSED.
    executeNowClosed();
    break;
}
```

case子句可以有局部变量，只能在该子句的范围内可见。

## 循环

### for 和 foreach

```dart
var message = StringBuffer('Dart is fun');
for (var i = 0; i < 5; i++) {
  message.write('!');
}//Dart is fun!!!!!
```

Dart for循环内部的闭包捕获了索引的值

```dart
var callbacks = [];
for (var i = 0; i < 2; i++) {
  callbacks.add(() => print(i));
}
callbacks.forEach((c) => c());
//0 1

//======//
var callbacks = [];
for (var i = 0; i < 2; i++) {
   callbacks.add(i);
}
for(var a in callbacks){
   print(a);
}//0 1
```

​		如果要迭代的对象是可迭代的，那么可以使用forEach()方法。使用forEach()本身是没有迭代计数器的，也就是for循环本身有i值在forEach()本身是没有的。

```dart
//candidates.forEach((candidate) => candidate.interview());
  Set str = {"sss","eee","rrr","ttt"};
  str.forEach((c)=>print(c));
/*
sss
eee
rrr
ttt
*/
```

### 遍历 for-in

可迭代类如List和Set也支持for-in形式的迭代:

```dart
var collection = [0, 1, 2];
for (var x in collection) {
  print(x); // 0 1 2
}
```

### while

while循环在循环之前先检验条件是否为真，例如：

```dart
while (!isDone()) {
  doSomething();
}
```

### do-while

do-while循环在一次循环结束之后检查条件是否为真，例如：

```dart
do {
  printLine();
} while (!atEndOfPage());
```

## break 和 continue

使用break终止循环：

```dart
  List<int> candidates = [1,2,7,4,5];
  for (int i = 0; i < candidates.length; i++) {
    var candidate = candidates[i];
    if (candidate > 5) {
      break;
    }
    print(candidate);
  }
// 1 2     7大于5所以终止循环，只输出 1 2
```

使用continue跳出本次循环继续下次循环：

```dart
  List<int> candidates = [1,2,7,4,5];
  for (int i = 0; i < candidates.length; i++) {
    var candidate = candidates[i];
    if (candidate > 5) {
      continue;
    }
    print(candidate);
  }
//当candidate > 5就会跳出当前循环执行下一轮循环
//1 2 4 5
```

如果你使用的是可迭代的，比如列表或集合，你可能会用不同的方式来写这个例子:

```dart
candidates
    .where((c) => c.yearsExperience >= 5)
    .forEach((c) => c.interview());
```

```dart
//解释上段代码
class A {
  var yearsExperience;
  A(int year)
  {
    this.yearsExperience = year;
  }
  interview() {
    print(this.yearsExperience);
  }
}

void main() {
  List personList = [
    A(1),
    A(2),
    A(5),
    A(6)
  ];

  ///第一种写法
  for(int i = 0; i < personList.length; i++) {
    var person = personList[i];
    if (person.yearsExperience < 5) {
      continue;
    }
    person.interview();
  }

  ///第二种写法
  personList
      .where((c) => c.yearsExperience >= 5)
      .forEach((c) => c.interview());
}
//5 6 5 6
//where()中返回可迭代对象，则继续调用foreach
//如返回为null，则不再调用foreach 并且无错误信息
//相似条件过滤器
```

## assert 断言

如果布尔条件为false，则使用assert语句中断正常执行。

断言的第一个参数可以是任何解析为布尔值的表达式。如果表达式的值为true，则断言成功并继续执行。如果是false，则断言失败，并抛出异常(AssertionError)。

要将提示消息附加到断言，请添加一个字符串作为第二个参数。

```dart
assert(urlString.startsWith('https'),
    'URL ($urlString) should start with "https".');
```