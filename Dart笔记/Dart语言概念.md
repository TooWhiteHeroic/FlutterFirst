## 重要概念

- 在变量中可以放置的所有东西都是对象，而每个对象都是类的实例。无论数字、函数和null都是对象。所有对象都继承自Object类。
- 尽管Dart是强类型的，但类型声明是可选的，因为Dart可以推断类型。 在上面的代码中，数字被推断为int类型。 如果要明确说明不需要任何类型，请使用[特殊类型dynamic]。
- Dart支持通用类型，如List<int>(整数列表)或List<dynamic>(任何类型的对象列表)。
- Dart支持顶级函数(如main())，以及绑定到类或对象(分别是静态方法（static）和实例（instance）方法)的函数。您还可以在函数(嵌套或局部函数)中创建函数。
- 类似地，Dart支持顶级变量，以及绑定到类或对象(静态和实例变量)的变量。实例变量有时被称为字段或属性。
- 与Java不同，Dart没有公开、保护和私有的关键字。如果标识符以下划线(_)开头，则该标识符对其库是私有的。_
- 标识符可以以字母或下划线(_)开头，然后是这些字符加上数字的任何组合。
- 有时候，某事物是一个表达（expression）还是一个语句（statement）是很重要的，所以这两个词要准确。
- Dart工具可以报告两种问题:警告和错误。警告只是表明您的代码可能不工作，但它们不会阻止您的程序执行。错误可以是编译时错误，也可以是运行时错误。编译时错误阻止了代码的执行;运行时错误导致代码执行时引发异常。

## 关键词

|     一列      |      二列      |     三列      |    四列     |
| :-----------: | :------------: | :-----------: | :---------: |
| abstract (1)  |       do       |  import (1)   |    super    |
|    as (1)     |  dynamic (1)   |      in       |   switch    |
|    assert     |      else      | interface (1) |  sync* (2)  |
|   async (2)   |      enum      |      is       |    this     |
|  async* (2)   |   export (1)   |  library (1)  |    throw    |
|   await (2)   |  external (1)  |   mixin (1)   |    true     |
|     break     |    extends     |      new      |     try     |
|     case      |  factory (1)   |     null      | typedef (1) |
|     catch     |     false      | operator (1)  |     var     |
|     class     |     final      |   part (1)    |    void     |
|     const     |    finally     |    rethrow    |    while    |
|   continue    |      for       |    return     |    with     |
| covariant (1) |    get (1)     |    set (1)    |  yield (2)  |
|    default    |       if       |  static (1)   |   yield*    |
| deferred (1)  | implements (1) |               |             |

(1)带有上标1的单词是内置标识符。避免使用内置标识符作为标识符。如果尝试为类或类型名使用内置标识符，则会发生编译时错误。
(2)使用上标2的单词是在Dart的1.0版本之后添加的与异步支持相关的更新的、有限的保留字。在以async, async*, 或者 sync* 标记的任何函数体中，不能使用async, await, 或者 yield作为标识符。