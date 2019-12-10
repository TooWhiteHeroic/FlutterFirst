# Dart 类

Dart是一种面向对象的语言，具有类和基于mixin的继承。每个对象都是一个类的实例，所有的类都是Object的子类。基于mixin的继承意味着，尽管每个类(除了Object)都只有一个超类，但类主体可以在多个类层次结构中重用。

## 使用类成员

对象具有由函数和数据(分别是方法和实例变量)组成的成员。当您调用一个方法时，您在一个对象上调用它:该方式可以访问该对象的函数和数据。

使用点号(.)引用实例变量或方法:

```dart
var p = Point(2, 2);

// Set the value of the instance variable y.
p.y = 3;

// Get the value of y.
assert(p.y == 3);

// Invoke distanceTo() on p.
num distance = p.distanceTo(Point(4, 4));
```

为避免最左操作数为空时出现异常，使用 ?.代替 .来使用：

```dart
// If p is non-null, set its y value to 4.
p?.y = 4;
```

## 使用构造函数

您可以使用构造函数创建一个对象。构造函数名可以是ClassName或ClassName.identifier。例如，以下代码使用Point()和Point. fromjson()构造函数创建点对象:

```dart
var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});
```

下面的代码具有相同的效果，但是在构造函数名之前使用可选的new关键字:

```dart
var p1 = new Point(2, 2);
var p2 = new Point.fromJson({'x': 1, 'y': 2});
```

> 版本注意事项：在Dart2中new关键字为可选关键字

有些类提供常量构造函数。要使用常量构造函数创建编译时常量，请将const关键字放在构造函数名之前:

```dart
var p = const ImmutablePoint(2, 2);
```

构造两个相同的编译时常量会生成一个单一的、规范的实例:

```dart
var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);

assert(identical(a, b)); // They are the same instance!
```

在常量上下文中，可以在构造函数或文字之前省略const。例如，看看这个代码，它创建了一个const的 map集合:

```dart
// Lots of const keywords here.
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};
```

除了第一次使用const关键字之外其他的const都可以省略：

```dart
// Only one const, which establishes the constant context.
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
```

> 版本说明:const关键字在Dart 2的常量上下文中变成可选的。

## 获得对象的类型

要在运行时获得对象类型，可以使用对象的runtimeType属性，该属性返回一个类型对象。

```dart
print('The type of a is ${a.runtimeType}');
```

到这里，您已经了解了如何使用类。本节的其余部分将展示如何实现类。

## 实例变量

下面是如何声明实例变量的方法:

```dart
class Point {
  num x; // Declare instance variable x, initially null.
  num y; // Declare y, initially null.
  num z = 0; // Declare z, initially 0.
}
```

所有未初始化的实例变量都具有null值。

所有实例变量都生成隐式getter方法。非最终实例变量也生成隐式setter方法。有关详细信息，请参见[Getters和setters]。

```dart
class Point {
  num x;
  num y;
}

void main() {
  var point = Point();
  point.x = 4; // Use the setter method for x.
  assert(point.x == 4); // Use the getter method for x.
  assert(point.y == null); // Values default to null.
}
```

如果在声明实例变量的地方(而不是在构造函数或方法中)初始化实例变量，则在创建实例时(在构造函数及其初始化列表执行之前)设置该值。