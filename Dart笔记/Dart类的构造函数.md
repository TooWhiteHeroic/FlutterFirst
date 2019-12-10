# Dart 构造函数

通过创建一个与类同名的函数来声明构造函数(另外，还可以像[命名构造函数]中描述的一样选择一个附加标识符)。构造函数最常见的应用形式是使用构造函数生成一个类的新实例：

```dart
class Point {
  num x, y;

  Point(num x, num y) {
    // There's a better way to do this, stay tuned.
    this.x = x;
    this.y = y;
  }
}
```

this关键字是指当前实例。

> 注意:只有在名称冲突时才使用它。否则，Dart的代码风格需要省略this

使用构造函数的参数为实例复制的使用非常常见，Dart具有语法上的优势，使这种使用更容易实现：

```dart
class Point {
  num x, y;

  // Syntactic sugar for setting x and y
  // before the constructor body runs.
  Point(this.x, this.y);
}
```

## 默认构造函数

如果不声明构造函数，则为您提供默认构造函数。默认构造函数没有参数，并在超类中调用无参数构造函数。

## 构造函数不是继承

子类不从父类继承构造函数。没有声明构造函数的子类只有默认的构造函数（没有参数，没有名称）而不是从父类继承的构造函数。

## 命名的构造函数

使用命名构造函数可以在一个类中定义多个构造函数，或者让一个类的作用对于开发人员来说更清晰：

```dart
class Point {
  num x, y;

  Point(this.x, this.y);

  // Named constructor
  Point.origin() {
    x = 0;
    y = 0;
  }
}
```

一定要记住构造函数是不会从父类继承的，这意味着父类的命名构造函数子类也不会继承。如果你希望使用在超类中定义的命名构造函数来创建子类，则必须在子类中实现该构造函数。

## 调用非默认的超类构造函数

默认情况下，子类中的构造函数调用父类的未命名的无参数构造函数。父类的构造函数在构造函数体的开始处被调用。如果类中有使用初始化列表，初始化列表将在调用超类之前执行。综上所述，执行顺序如下:

- 初始化列表
- 超类中的无参数构造函数
- main类中的无参数构造函数

如果超类没有未命名的无参数构造函数，则必须手动调用超类中的一个构造函数。在冒号(:)之后，在构造函数体(如果有的话)之前指定超类构造函数。

在下例中，Employee类的构造函数中调用了他的超类Person中的命名构造函数。

```dart
class Person {
  String firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}

main() {
  var emp = new Employee.fromJson({});

  // Prints:
  // in Person
  // in Employee
  if (emp is Person) {
    // Type check
    emp.firstName = 'Bob';
  }
  (emp as Person).firstName = 'Bob';
}

///结果输出为
in Person
in Employee
```

因为父类构造函数的参数是在调用构造函数之前执行的，所以参数可以是表达式，比如函数调用:

```dart
class Employee extends Person {
  Employee() : super.fromJson(getDefaultData());
  // ···
}
```

> 警告：在超类的构造函数的参数中不能使用this关键字。例如，参数可以调用static方法但是不能调用实例方法

## 初始化列表

除了调用超类构造函数之外，还可以在构造函数主体运行之前初始化实例变量。初始值设定项用逗号分开。

```dart
// Initializer list sets instance variables before
// the constructor body runs.
Point.fromJson(Map<String, num> json)
    : x = json['x'],
      y = json['y'] {
  print('In Point.fromJson(): ($x, $y)');
}
```

> 警告:初始化器的右边部分中无法访问this关键字。

在开发期间，可以通过在初始化列表中使用assert来验证输入。

```dart
Point.withAssert(this.x, this.y) : assert(x >= 0) {
  print('In Point.withAssert(): ($x, $y)');
}
```

初始化列表在设置final字段时很方便。下面的示例初始化初始化列表中的三个final字段：

```dart
import 'dart:math';

class Point {
  final num x;
  final num y;
  final num distanceFromOrigin;

  Point(x, y)
      : x = x,
        y = y,
        distanceFromOrigin = sqrt(x * x + y * y);
}

main() {
  var p = new Point(2, 3);
  print(p.distanceFromOrigin);
}

///运行结果
3.605551275463989
```

## 重定向构造函数

有时，构造函数的唯一目的是重定向到同一个类中的另一个构造函数。重定向构造函数的主体为空，构造函数调用出现在冒号(:)之后。

```dart
class Point {
  num x, y;

  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(num x) : this(x, 0);
}
```

## 常量构造函数

如果您的类生成的对象不会改变，您可以使这些对象成为编译时常量。为此，定义一个const构造函数，并确保所有实例变量都是final的。

```dart
class ImmutablePoint {
  static final ImmutablePoint origin =
      const ImmutablePoint(0, 0);

  final num x, y;

  const ImmutablePoint(this.x, this.y);
}
```

## 工厂构造函数

在实现构造函数时使用factory关键字，该构造函数并不总是创建类的新实例。例如，工厂构造函数可以从缓存返回实例，也可以返回子类型的实例。

以下示例演示工厂构造函数从缓存返回对象:

```dart
class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache =
      <String, Logger>{};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}
```

> 注意:工厂构造函数不能访问this关键字。

调用工厂构造函数，就像调用其他构造函数一样:

```dart
var logger = Logger('UI');
logger.log('Button clicked');
```