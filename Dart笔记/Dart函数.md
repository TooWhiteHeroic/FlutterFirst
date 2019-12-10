# 函数

Dart是一种真正的面向对象语言，所以即使函数也是对象，具有类型和功能。这意味着函数可以分配给变量或作为参数传递给其他函数。您还可以像调用函数一样调用Dart类的实例。

这里有一个实现函数的例子:

```dart
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

函数类型可忽略

```dart
isNoble(atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}
```

对于只包含一个表达式的函数，可以使用简写语法:

```dart
bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
```

=> expr 语法是{return expr;}的简写写法。“=>”符号有时被称为胖箭头语法。

> 注意:在箭头(=>)和分号(;)之间只能出现一个表达式(不是语句块)。例如，您不能在那里放一个if语句，但是您可以使用一个条件表达式。bool ? a : b

## 可选参数

**可选参数可以是位置参数，也可以是命名参数，但不能两者都是。**

#### 可选的命名参数

在调用函数时，可以使用paramName: value来指定命名参数。例如:

```dart
enableFlags(bold: true, hidden: false);
//也可以使用 =
enableFlags(bold=true, hidden=false);
```

在定义函数时，使用{param1, param2，…}来指定命名参数:

```dart
void enableFlags({bool bold, bool hidden}) {...}
```

Flutter实例创建表达式可能会变得复杂，因此widget构造函数只使用命名参数。这使得实例创建表达式更容易阅读。

您可以在任何Dart代码(不仅仅是Flutter)中注释一个已命名的参数，并使用**@required**说明它是一个必传的参数。例如:

```dart
const Scrollbar({Key key, @required Widget child})
```

当构造Scrollbar时，分析器在没有子参数时报错。Required在元包中被定义。或者直接使用import package:meta/meta.dart导入或者导入其他包含meta导出的包，例如Flutter的包:Flutter /material.dart。

#### 可选的位置参数

在[]中包装一组函数参数，标记为可选的位置参数:

```dart
String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
```

这里有一个调用这个函数的例子，没有可选参数:

```dart
assert(say('Bob', 'Howdy') == 'Bob says Howdy');
```

这里有一个用第三个参数调用这个函数的例子:

```dart
assert(say('Bob', 'Howdy', 'smoke signal') ==
    'Bob says Howdy with a smoke signal');
```

### 默认参数值

您的函数可以使用 = 来定义命名和位置参数的默认值。默认值必须是编译时常量。如果没有提供默认值，则默认值为null。

下面是为命名参数设置默认值的示例:

```dart
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool bold = false, bool hidden = false}) {...}

// bold will be true; hidden will be false.
enableFlags(bold: true);
```

> 弃用注释:旧代码可能使用冒号(:)而不是=来设置命名参数的默认值。原因是最初，只有:被命名参数支持。这种支持很可能被弃用，因此我们建议您使用=来指定默认值。

下一个示例展示了如何设置位置参数的默认值:

```dart
String say(String from, String msg,
    [String device = 'carrier pigeon', String mood]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  if (mood != null) {
    result = '$result (in a $mood mood)';
  }
  return result;
}

assert(say('Bob', 'Howdy') ==
    'Bob says Howdy with a carrier pigeon');
    
```

您还可以将list或map集合作为默认值。下面的示例定义一个函数doStuff()，该函数指定列表参数的默认列表和礼品参数的默认map集合。

```dart
void doStuff({List<int> list = const [1, 2, 3],
    	Map<String, String> gifts = const {
      	'first': 'paper',
      	'second': 'cotton',
      	'third': 'leather'
    	}
    }) {
  print('list:  $list');
  print('gifts: $gifts');
}
```

## main() 函数

每个应用程序都必须有一个顶级的main()函数，它作为应用程序的入口点。main()函数返回void，并有一个可选的列表参数作为参数。

下面是web应用程序的main()函数示例:

```dart
void main() {
  querySelector('#sample_text_id')
    ..text = 'Click me!'
    ..onClick.listen(reverseText);
}
```

> 注意：代码前的(..)语法被称为级联。使用级联，可以对单个对象的成员执行多个操作。

下面是一个命令行应用程序的main()函数示例，它接受参数:

```dart
// Run the app like this: dart args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
```

您可以使用args库来定义和解析命令行参数。

## Functions as first-class objects

可以将函数作为参数传递给另一个函数。例如:

```dart
void printElement(int element) {
  print(element);
}

var list = [1, 2, 3];

// forEach源码中需要传参 参数就是传一个void fun()
list.forEach(printElement);
// 1 2 3
```

你也可以为变量分配一个函数，例如:

```dart
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';//匿名函数 ()=>{} 可传值
assert(loudify('hello') == '!!! HELLO !!!');
```

这个例子使用一个匿名函数。下一节将详细介绍这些内容。

## 匿名函数

大多数函数都被命名，如main()或printElement()。你也可以创建一个没有函数名称的函数，这种函数称为匿名函数，或者lambda函数或者闭包函数。您可以为变量分配一个匿名函数，例如，您可以从集合中添加或删除它。

匿名函数看起来类似于命名函数--有0个或者多个参数，在括号之间用逗号和可选类型标注分隔。后面的代码块包含函数的主体:

```dart
([[Type] param1[, …]]) { 
  codeBlock; 
}; 
```

下面的示例定义了一个带有无类型参数item的匿名函数。该函数为列表中的每个item调用，打印一个字符串，该字符串包含指定索引的值。

```dart
var list = ['apples', 'bananas', 'oranges'];
list.forEach((item) {
  print('${list.indexOf(item)}: $item');
});
//结果：
0: apples
1: bananas
2: oranges
```

如果函数只包含一条语句，可以使用胖箭头符号来缩短它。

```dart
list.forEach(
    (item) => print('${list.indexOf(item)}: $item')
);
```

## 词法作用域

Dart是一种在词法上确定范围的语言，这意味着变量的范围是静态的，仅仅是通过代码的布局来决定的。您可以“跟随花括号向外”以查看变量是否在范围内。

这里有一个嵌套函数的例子，每个作用域级别上都有变量:

```dart
//内可以用外，外不能用内
bool topLevel = true;

void main() {
  var insideMain = true;

  void myFunction() {
    var insideFunction = true;

    void nestedFunction() {
      var insideNestedFunction = true;

      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }
}
```

## 词法闭包

闭包是一个函数对象，它可以访问其词法范围内的变量，即使函数在其原始范围之外使用。

函数可以关闭周围作用域中定义的变量。在下面的示例中，makeAdder()捕获变量addBy。无论返回的函数到哪里，它都会记住addBy。

```dart
Function makeAdder(num addBy) {
  return (num i) => addBy + i;
}
void main() {
  var add2 = makeAdder(2);
  var add4 = makeAdder(4);
  assert(add2(3) == 5);
  assert(add4(3) == 7);
}
```

## 判断函数相等

下面是一个测试顶级函数、静态方法和相等实例方法的示例:

```dart
void foo() {} // A top-level function 顶级函数              返回null

class A {
  static void bar() {} // A static method 静态方法
  void baz() {} // An instance method
}

void main() {
  var x;
  // Comparing top-level functions.
  x = foo;
  assert(foo == x);//应该是相等的

  // Comparing static methods.
  x = A.bar;
  assert(A.bar == x); 

  // Comparing instance methods.
  var v = A(); // Instance #1 of A
  var w = A(); // Instance #2 of A
  var y = w;
  x = w.baz;

  // These closures refer to the same instance (#2),
  // so they're equal.
  assert(y.baz == x);

  // These closures refer to different instances,
  // so they're unequal.
  assert(v.baz != w.baz);
}
```

## 返回值

所有函数都返回一个值。如果没有指定返回值，则语句返回null;隐式附加到函数体。

```dart
foo() {}
assert(foo() == null);
```