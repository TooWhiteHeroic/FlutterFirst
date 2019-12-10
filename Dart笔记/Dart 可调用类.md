# 模拟函数

实现call()方法可以让你的Dart类像函数一样被调用。

在下面的示例中，WannabeFunction类定义了一个call()函数，该函数接受三个字符串并将它们连接起来，每个字符串用空格分隔，并在结尾加一个感叹号。

```dart
class WannabeFunction {
  call(String a, String b, String c) => '$a $b $c!';
}

main() {
  var wf = new WannabeFunction();
  var out = wf("Hi", "there,", "gang");
  print('$out');
}

///执行结果
Hi there, gang!
```