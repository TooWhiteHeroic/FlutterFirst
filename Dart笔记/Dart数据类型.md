# 变量

var or dynamic 声明的变量不限于单一类型（动态类型）

```dart
var val = 1;  // int类型
dynamic abc = "ddd"; //string 类型
Object adc = "我是射手";
```

数据类型声明的变量为单一相对于的类型（显式）

```dart
String a = "111";// 字符串
List b = [1,2,3,4]; // 列表
```

final or const 声明的变量，只能赋值一次  并且不能同时使用

```dart
final name = 'Bob'; // 类型根据赋值自动转换
final String nickname = 'Bobby';
//当再次赋值就会报错
name = 'Alice'; // Error: a final variable can only be set once.
//final 定义的常量是运行时常量
//const 定义的常量是编译时常量
```

**如果您从未打算更改一个变量，请使用final或const修饰他，而不是使用var或其他变量类型。最终变量只能设置一次;const变量是一个编译时常数。(Const变量是隐式最终变量。)最终的顶级或类变量在第一次使用时被初始化。**

注意:实例变量可以是final，但不能是const。[*实例变量定义在对象一级，它可以被类中的任何方法或者其他类中的方法访问，但是不能被静态方法访问。*]

<font color="#f00">初始化未赋值变量值为null，为什么值为null，因为dart任何类型都是一个对象</font>

final 用于修饰变量，表示单赋值，使用final修饰的变量必须进行初始化，一旦被赋值之后不能再次赋值

static 用于修饰成员变量，这个变量属于类，而不是属于对象的，除此之外无其他含义和java使用一致，运行时被使用变量才会实例化

final与const的共同点：

声明类型可以省略 - 初始化后不能再赋值 - 不能和var一起使用

# Dart 数据类型

## Numbers 数字

- int  整型

  ```dart
    int i = 1;
    int hex = -0xDEADBEEF;
  //不大于64位   -2^63到2^63-1
  ```

- double  浮点型

  ```dart
  double dou = 1.2;double exp = 1.2e-5;
  //64位(双精度)浮点数
  ```

  都能使用基本运算符和一些math函数以及位运算符

  ### 转型

  ```dart
  // String -> int
  var one = int.parse('1');
  // String -> double
  var onePointOne = double.parse('1.1');
  // int -> String
  String oneAsString = 1.toString();
  // double -> String
  String piAsString = 3.14159.toStringAsFixed(2);
  ```

  **数字字面量是编译时常量。许多算术表达式也是编译时常量，只要它们的操作数是编译时常量，可以对数字求值。**

  ```dart
  const a = 1;
  const b = 2;
  const c = a * b;//c=2
  ```

---

## String 字符串

UTF-16编码单元的序列,使用单引号或双引号创建一个字符串

```dart
var s1 = 'Single quotes work well for string literals.';
var s2 = "Double quotes work just as well.";
var s3 = 'It\'s easy to escape the string delimiter.';
var s4 = "It's even easier to use the other delimiter.";
```

字符串插值  用$

```dart
var s = 'string interpolation';
assert('Dart has $s, which is very handy.' == 'Dart has string interpolation, ' + 'which is very handy.');
assert('That deserves all caps. ' + '${s.toUpperCase()} is very handy!' == 'That deserves all caps. ' + 'STRING INTERPOLATION is very handy!');
//==检验两个对象是否相等。如果两个字符串包含相同序列的代码单元，那么它们是等价的
```

""" “”“，‘’‘ ’‘’ 包裹创建多行字符串

```dart
var s1 = 
'''
You can create
multi-line strings like this one.
''';
var s2 = """This is also a
multi-line string.""";
```

用r前缀创建一个“原始”字符串  

```dart
var s = r'In a raw string, not even \n gets special treatment.';
// In a raw string, not even \n gets special treatment.
var sstr = 'In a raw string, not even \n gets special treatment.';
/*
In a raw string, not even 
gets special treatment.
*/
```

字符串字面量是编译时常量，只要任何内插表达式都是编译时常量，计算结果为null或数值、字符串或布尔值

```dart
// These work in a const string.
const aConstNum = 0;
const aConstBool = true;
const aConstString = 'a constant string';
const validConstString = '$aConstNum $aConstBool $aConstString';

// These do NOT work in a const string.
var aNum = 0;
var aBool = true;
var aString = 'a string';
const aConstList = [1, 2, 3];
const invalidConstString = '$aNum $aBool $aString $aConstList';
//报语法错误
var invalidConstString = '$aNum $aBool $aString $aConstList';
//运行通过结果：   0 true a string [1, 2, 3]
```

---

## Booleans 布尔值

为了表示布尔值，Dart有一个名为bool的类型。只有两个对象具有bool类型：布尔字面量true和false，它们都是编译时常量。

Dart的类型安全性意味着您不能使用if(非booleanvalue)或assert(非booleanvalue)之类的代码。相反，显式地检查值

```dart
// Check for an empty string.
var fullName = '';
assert(fullName.isEmpty);

// Check for zero.
var hitPoints = 0;
assert(hitPoints <= 0);

// Check for null.
var unicorn;
assert(unicorn == null);

// Check for NaN.
var iMeantToDoThis = 0 / 0;
assert(iMeantToDoThis.isNaN);
```

---

## Lists 列表or数组

也许几乎所有编程语言中最常见的集合就是数组或有序对象组。在Dart中，数组是列表对象，所以大多数人把它们叫做列表。

```dart
var list = [1, 2, 3]; //默认int类型 根据数组元素判断
//下标从0开始
//创建指定类型数组
List arr = <int>[1,2,3];
```

Dart 2.3还引入了**collection if**和**collection for**，您可以使用 if 和 for 来构建集合。

```dart
var nav = [ 'Home' , 'Furniture' ,'Plants' ,if (true) 'Outlet' ];
//[Home, Furniture, Plants, Outlet]
var nav = [ 'Home' , 'Furniture' ,'Plants' ,if (false) 'Outlet' ];
//[Home, Furniture, Plants]
//===============================================================================
var listOfInts = [1, 2, 3];
var listOfStrings = [
  '#0',
  for (var i in listOfInts) '#$i'
];
//listOfStrings = [#0, #1, #2, #3]
```

---

## Sets 集合

不能重复

```dart
//简单创建
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
//声明一个只存String的空集
var names = <String> {};
//或 <String> names = {}; //这也有效

var names = {}; //这是创建一个Map，而不是一个Set。

//===============================================================================
var elements = <String>{};
elements.add('Ca');
elements.addAll(halogens);
//elements:{Ca, fluorine, chlorine, bromine, iodine, astatine}
```

---

## Maps 映射or字典

map是一个关联键和值的对象。键和值都可以是任何类型的对象。每个键只出现一次，但是您可以多次使用相同的值。Dart对map的支持是通过map字面量和map类型来提供的。

```dart
//创建map
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};
var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};
//添加一个新key-value
nobleGases[1] = 'birds';
//检索map
nobleGases[10] 
//获取的key不在map中则返回null
```

---

## Runes 字符

在Dart中，字符是字符串的UTF-32编码点。

Unicode为世界上所有的书写系统中使用的每个字母、数字和符号定义一个唯一的数值。因为Dart字符串是UTF-16代码单元的序列，所以在字符串中表示32位的Unicode值需要特殊的语法。

表示Unicode码点的常用方法是\uXXXX，其中XXXX是4位数的十六进制值。例如,心型字符(♥)的编码为\ u2665。要指定大于或小于4位十六进制数字，请将值放在花括号中。例如笑脸表情(😆)的编码\u{1f600}.

String类有几个属性可以用来获取runes信息。codeUnitAt和codeUnit属性返回16位代码单元。使用字符属性获取字符串的字符。

```
main() {
  var clapping = '\u{1f600}';
  print(clapping);
  print(clapping.codeUnits);
  print(clapping.runes.toList());

  Runes input = new Runes(
      '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
  print(new String.fromCharCodes(input));
}
```

---

## Symbols 符号

符号对象表示在Dart程序中声明的操作符或标识符。您可能永远不需要使用符号，但是对于按名称引用标识符的api来说，它们是非常重要的，因为缩小改变了标识符名称而不是标识符符号。

要获取标识符的符号，请使用符号文字，符号文字仅为#，后面跟着标识符:

```
#radix
#bar
```

符号常量是编译时常量。

---