# 重写与mixins特性

## 重写类的成员

子类可以覆盖实例方法、getter和setter。您可以使用@override注释来指示你重写了某个成员方法:

```dart
class SmartTelevision extends Television {
  @override
  void turnOn() {...}
  // ···
}
```

要在类型安全的代码中缩小方法参数或实例变量的类型，可以使用covariant关键字。

## 重写操作符

您可以重写下表中显示的操作符。例如，如果定义一个Vector类，可以定义一个+方法来让两个向量相加。

| <    | +    | \|   | []   |
| :--- | :--- | :--- | :--- |
| >    | /    | ^    | []=  |
| <=   | ~/   | &    | ~    |
| >=   | *    | <<   | ==   |
| -    | %    | >>   |      |

下例在类中重写了+和-操作符：

```dart
class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  // Operator == and hashCode not shown. For details, see note below.
  // ···
}

void main() {
  final v = Vector(2, 3);
  final w = Vector(2, 2);

  assert(v + w == Vector(4, 5));
  assert(v - w == Vector(0, 1));
}
```

如果重写==，还应该重写对象的hashCode getter。有关override == 和hashCode的示例，请参见[ Implementing map keys]。

有关重写的更多信息，请参见[扩展类]。

## noSuchMethod()

可以重写noSuchMethod()方法来处理程序访问一个不存在的方法或者成员变量：

```dart
class A {
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: ' +
        '${invocation.memberName}');
  }
}
```

您不能调用未实现的方法，除非下列任何一个是正确的:

- 被调用者有静态方法dynamic
- 被调用者有一个静态类型来定义未实现的方法(抽象也可以OK)，而接收者的动态类型有一个noSuchMethod()的实现，它与类对象中的方法不同。

## mixins

mixin是在多个类层次结构中重用类代码的一种方式。

要使用mixin，请在with关键字后面加上一个或多个mixin名称。下面的例子显示了两个使用mixin的类:

```dart
class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person
    with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
```

要实现mixin，创建一个Object的子类，不声明构造函数，也不调用super。例如:

```dart
abstract class Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}
```

> 注意:一些对mixin的限制要被删除。有关详细信息，请参见建议的[mixin规范]。