# Dart 生成器

当您需要延迟地生成一个值序列时，请考虑使用生成器函数。Dart内置支持两种生成器函数:

- 同步生成器：返回Iterable对象
- 异步生成器：返回Stream对象

要实现同步生成器函数，将函数体标记为sync*，并使用yield语句传递值:

```dart
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}
```

要实现异步生成器函数，将函数体标记为async*，并使用yield语句传递值:

```dart
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}
```

如果您的生成器是递归的，您可以使用yield*来改进它的性能:

```dart
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}
```