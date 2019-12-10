# dart 类的方法与抽象类

方法是为对象提供行为的函数。

## 实例方法

对象上的实例方法可以访问实例变量。下面示例中的distanceTo()方法是一个实例方法的示例:

```dart
import 'dart:math';

class Point {
  num x, y;

  Point(this.x, this.y);

  num distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}
```

## Getters 和 setters 方法

getter和setter是对对象属性的读写访问的特殊方法。回想一下，每个实例变量都有一个隐式的getter，如果需要的话还可以加上一个setter。使用get和set关键字来实现getter和setter方法可以来读写其他属性：

```dart
class Rectangle {
  num left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Define two calculated properties: right and bottom.
  num get right => left + width;
  set right(num value) => left = value - width;
  num get bottom => top + height;
  set bottom(num value) => top = value - height;
}

void main() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}
```

使用getter和setter，你可以使用方法包装实例变量，而无需改动业务代码。

> 注意:诸如increment(++)之类的操作符以预期的方式工作，无论getter是否被显式定义。为了避免任何意外的副作用，操作符只调用getter一次，将其值保存在一个临时变量中。

## 抽象方法

实例方法、getter和setter方法可以是抽象方法，之定义一个接口但是将具体实现留给其他类。抽象方法只能存在于抽象类中，抽象方法是没有方法体的。

```dart
abstract class Doer {
  // Define instance variables and methods...

  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}
```

调用抽象方法会导致运行时错误。

## 抽象类

使用abstract修饰符定义不能实例化的抽象类。抽象类对于定义接口非常有用。如果您希望抽象类看起来是可实例化的，请定义一个工厂构造函数。

抽象类通常有抽象方法。这里有一个声明抽象类的例子，它有一个抽象的方法:

```dart
// This class is declared abstract and thus
// can't be instantiated.
abstract class AbstractContainer {
  // Define constructors, fields, methods...

  void updateChildren(); // Abstract method.
}
```

## 类方法和类变量

使用static关键字实现类范围的变量和方法。

## 静态变量

静态变量(类变量)对于类范围内的状态和常量是有用的:

```dart
class Queue {
  static const initialCapacity = 16;
  // ···
}

void main() {
  assert(Queue.initialCapacity == 16);
}
```

静态变量在使用之前不会初始化。

> 注意:此页面遵循代码样式规范，对常量名使用小驼峰命名法。

## 静态方法

静态方法(类方法)不对实例进行操作，因此无法访问该实例。例如:

```dart
import 'dart:math';

class Point {
  num x, y;
  Point(this.x, this.y);

  static num distanceBetween(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}

void main() {
  var a = Point(2, 2);
  var b = Point(4, 4);
  var distance = Point.distanceBetween(a, b);
  assert(2.8 < distance && distance < 2.9);
  print(distance);
}
```

> 注意:对于通用或广泛使用的实用程序和功能，考虑使用顶级函数，而不是静态方法。

可以使用静态方法作为编译时常量。例如，可以将静态方法作为参数传递给常量构造函数。