# Dart 操作符

| 描述           | 操作符（优先级从高到低）                                     |
| -------------- | ------------------------------------------------------------ |
| 一元后置操作符 | expr++    expr--    ()    []    .    ?.                      |
| 一元前置操作符 | -expr    !expr    ~expr    ++expr    --expr                  |
| 乘除           | *    /    %    ~/                                            |
| 加减           | +    -                                                       |
| 移位           | <<    >>                                                     |
| 按位与         | &                                                            |
| 按位异或       | ^                                                            |
| 按位或         | \|                                                           |
| 关系和类型测试 | >=    >    <=    <    as    is    is!                        |
| 相等           | ==    !=                                                     |
| 逻辑与         | &&                                                           |
| 逻辑或         | \|\|                                                         |
| 是否为null     | ??                                                           |
| 三元运算符     | expr1 ? expr2 : expr3                                        |
| 级联           | ..                                                           |
| 赋值           | =    *=    /=    ~/=    %=    +=    -=    <<=    >>=    &=    ^= |

## 算术运算符

```dart
//加
assert(2 + 3 == 5);
//减
assert(2 - 3 == -1);
//乘
assert(2 * 3 == 6);
//除 只返回double
assert(5 / 2 == 2.5);
//取模 只返回int
assert(5 ~/ 2 == 2); 
//取余 
assert(5 % 2 == 1);
```

## 自增 自减

与java雷同

````dart
var a, b;
//--------------------------------------------------------------------------
a = 0;
b = ++a; // 先自增后赋值
assert(a == b); // 1 == 1
//--------------------------------------------------------------------------
a = 0;
b = a++; // 先赋值后自增
assert(a != b); // 1 != 0
//--------------------------------------------------------------------------
a = 0;
b = --a; // 先自减后赋值
assert(a == b); // -1 == -1
//--------------------------------------------------------------------------
a = 0;
b = a--; //先赋值后自减
assert(a != b); // -1 != 0
````

## 相等和关系运算符

要测试两个对象x和y是否代表相同的东西，使用\==操作符,(在需要知道两个对象是否完全相同的情况下，可以使用 identical() 函数)。==操作符的工作原理如下:

- 如果x或y为空，如果两个都为空，则返回true;如果只有一个为空，则返回false。
- 返回方法调用x.= (y)的结果。（\==等操作符是在第一个操作数上调用的方法。您甚至可以覆盖许多操作符，包括==，您将在可覆盖操作符中看到）

```dart
assert(2 == 2);
assert(2 != 3);
assert(3 > 2);
assert(2 < 3);
assert(3 >= 3);
assert(2 <= 3);
```

## 类型测试操作符

| 操作符 | 说明                              |
| ------ | --------------------------------- |
| is     | 如果对象具有指定的类型，则为True  |
| is!    | 如果对象具有指定的类型，则为False |
| as     | 形态转换                          |

如果obj实现了T指定的接口，则obj is T为真，例如，obj is Object 总是为真。

使用as操作符将对象转换为特定类型。一般来说，您应该将其作为 is 测试的简写形式，以使用该对象的表达式对对象进行测试。

```dart
if (emp is Person) {
  // Type check
  emp.firstName = 'Bob';
}
//===代码不等效===//
(emp as Person).firstName = 'Bob';
//如果emp是null或不是Person，那么第一个示例(使用is)什么都不做;第二个(带有as)抛出异常。
```

## 赋值运算符

```dart
// =
a = 1;
//??=操作符仅仅在变量为null时会赋值。未初始化和后来手动赋值为null的情况都会执行此操作赋值。
//仅仅在b为空的情况下b被赋值value否则b的值不变 
b ??= value;
// -=
a -= b; //a - a = b
// /=
a /= b; //a / a = b
// %=
a %= b; //a % a = b
// >>=
a >>= b; //a >> a = b
// ^=
a ^= b; // a ^ a = b
// +=
a += b; // a + a = b
// *=
a *= b; // a * a = b
// ~/=
a ~/= b; // a ~/ a = b
// <<=
a <<= b; // a << a = b
// &=
a &= b; // a & a = b
// |=
a |= b; // a | a = b
```

## 逻辑运算符

| 运算符 | 说明                                                         |
| :----- | :----------------------------------------------------------- |
| !expr  | 对!后的表达式结果取反(如果表达式结果为false则表达式前加！使其变为true，反之亦然) 取反 |
| \|\|   | 逻辑或 满足一个条件 true                                     |
| &&     | 逻辑与（且） 条件都满足为true                                |

## 位和移位运算符

| 运算符 | 说明     |
| :----- | :------- |
| &      | 按位与   |
| \|     | 按位或   |
| ^      | 按位异或 |
| &~expr | 按位取反 |
| <<     | 左移     |
| >>     | 右移     |

```dart
final value = 0x22;
final bitmask = 0x0f;

assert((value & bitmask) == 0x02); // AND
assert((value & ~bitmask) == 0x20); // AND NOT
assert((value | bitmask) == 0x2f); // OR
assert((value ^ bitmask) == 0x2d); // XOR
assert((value << 4) == 0x220); // Shift left
assert((value >> 4) == 0x02); // Shift right
```

## 条件表达式

Dart有两个运算符，可以让你精确地计算那些可能需要if-else语句的表达式:

**condition ? expr1 : expr2**
如果条件为真，则计算expr1(并返回其值);否则，计算并返回expr2的值。

**expr1 ?? expr2**
如果expr1是非空的，则返回其值;否则，计算并返回expr2的值。

当您需要 基于布尔表达式的结果选择赋值，请考虑使用 ***?  :*** 。

```dart
var visibility = isPublic ? 'public' : 'private';
```

如果布尔表达式只想判断值是否为null，请考虑使用 ***??*** 。

```dart
String playerName(String name) => name ?? 'Guest';
```

前面的例子至少可以用以下另外两种方式来写，但是不够简洁:

```dart
// Slightly longer version uses ?: operator.
String playerName(String name) => name != null ? name : 'Guest';

// Very long version uses if-else statement.
String playerName(String name) {
  if (name != null) {
    return name;
  } else {
    return 'Guest';
  }
}
```

## 级联表示法

级联(..)允许您在同一个对象上创建一个操作序列。除了函数调用之外，您还可以访问同一对象上的字段。这通常可以省去创建临时变量的步骤，能使你更为流畅的写代码。

请看下边的代码：

```dart
querySelector('#confirm') // Get an object.
  ..text = 'Confirm' // Use its members.
  ..classes.add('important')
  ..onClick.listen((e) => window.alert('Confirmed!'));
```

首先调用querySelector()方法返回一个selector对象。跟随级联表示法的代码对这个选择器对象进行操作，忽略可能返回的任何后续值。

前面的例子等价于:

```dart
var button = querySelector('#confirm');
button.text = 'Confirm';
button.classes.add('important');
button.onClick.listen((e) => window.alert('Confirmed!'));
```

你也可以嵌套级联操作。例如：

```dart
final addressBook = (AddressBookBuilder()
      ..name = 'jenny'
      ..email = 'jenny@example.com'
      ..phone = (PhoneNumberBuilder()
            ..number = '415-555-0100'
            ..label = 'home')
          .build())
    .build();
```

在返回实际对象的函数上构造级联要小心。例如，以下代码会出错:

```dart
var sb = StringBuffer();
sb.write('foo')
  ..write('bar'); // Error: method 'write' isn't defined for 'void'.
```

上例中sb.write()返回结果为void，所以你不能再一个void结果上继续构建级联操作。

注意:严格地说，级联的“..”表示法不是运算符。这只是Dart语法的一部分。

## 其他运算符

| 运算符 | 名称             | 说明                                                         |
| :----- | :--------------- | :----------------------------------------------------------- |
| ()     | 功能函数         | 表示一个函数调用                                             |
| []     | 访问列表         | 引用列表中指定索引处的值                                     |
| .      | 访问成员         | 表示表达式的属性;例如:foo.bar从表达式foo中选择属性bar        |
| ?.     | 根据条件访问成员 | 和(.)相似，但是左边的操作数可以为空；例如： foo?.bar 从foo的表达式中选择bar属性，如果foo为空则返回null |

```dart
class A {
  var b;
}

void main() {
  /// aobj为A的一个实例
  var aobj = A();
  ///z为空值的变量
  var z=null;
  print(aobj.b);//null
  print(z?.b);//null
  print(z.b);//抛出异常
}
//使用（?.）如果取值对象为空时返回null但是使用（.）如果对象为空则抛出异常
```

