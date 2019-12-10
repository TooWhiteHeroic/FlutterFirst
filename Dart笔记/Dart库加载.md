# 库加载 或者说导包

## 使用库

```dart
import 'dart:html';//自带包
import 'package:test/test.dart';//项目包
```

## 给库添加前缀

```dart
import 'package:lib2/lib2.dart' as lib2;
```

## 只导入库的一部分

```dart
// 只导入 foo
import 'package:lib1/lib1.dart' show foo;
// 除了foo 其他都导入
import 'package:lib2/lib2.dart' hide foo;
```

## 延迟加载 or 懒加载

延迟加载(也称为懒加载)允许应用程序在需要时按需加载库。以下是一些您可能使用延迟加载的情况:

- 减少应用程序的初始启动时间。
- 例如，要执行A/B测试——尝试算法的其他实现。
- 加载很少使用的功能，如可选屏幕和对话框。

要延迟加载库，必须首先使用deferred as进行导入。

```dart
import 'package:greetings/hello.dart' deferred as hello;
```

当您需要库时，使用库的标识符调用loadLibrary()。

```dart
Future greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}
```

在前面的代码中，wait关键字暂停执行，直到加载库。有关async和waiting的更多信息，请参见[异步支持]。
您可以在库上多次调用loadLibrary()，没有问题。该库只加载一次。
在使用延迟加载时，请记住以下几点:

- 在导入文件中，库的常量不是常量。这些常量在延迟库加载之前是不存在的。
- 您不能在导入文件中使用来自延迟库的类型。相反，考虑将接口类型移动到由延迟库和导入文件导入的库。
- Dart隐式地将loadLibrary()插入到您定义使用deferred作为命名空间的空间中。