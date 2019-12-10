
//主程序入口
main(){

  //动态赋值
  dynamic a = true;
  var aa = 2;

  //显示赋值 基本数据类型
  int c = 3;
  double b = 1.1;
  String ss = "str";
  bool flag = true;
  List arr = [1,2,3,4,"5",6,"7",'8'];
  Map map = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings'
  };

  //只赋值一次
  const aaa = 2;
  final String str = "我丢";

  print(isType(map));
  //$ 字符串插值器
  print("arr:${isType(arr[7])}");

  outString(ss);

  CharDart();
}


//定义一个简单的函数
outString(String str){
  print("我们输出一个字符串:$str.");
}

isType(dynamic arg){
  if(arg is int){
    return "Int";
  }else if(arg is double){
    return "Double";
  }else if(arg is String){
    return "String";
  }else if(arg is bool){
    return "Boolean";
  }else if(arg is List){
    return "List";
  }else if(arg is Map){
    return "Map";
  }
}

CharDart(){
  //在Dart中，字符是字符串的UTF-32编码点。
  //Runes 是字符
  var clapping = '\u{1f600}';
  print(clapping);
  print(clapping.codeUnits);
  print(clapping.runes.toList());
  //String类有几个属性可以用来获取runes信息。codeUnitAt和codeUnit属性返回16位代码单元。使用字符属性获取字符串的字符。
  Runes input = new Runes(
      '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
  print(new String.fromCharCodes(input));
}
/**
 * Symbols（符号）
 * 符号对象表示在Dart程序中声明的操作符或标识符。您可能永远不需要使用符号，但是对于按名称引用标识符的api来说，它们是非常重要的，因为缩小改变了标识符名称而不是标识符符号。

    要获取标识符的符号，请使用符号文字，符号文字仅为#，后面跟着标识符:

    #radix
    #bar
    符号常量是编译时常量。
*/
/**
    在学习Dart语言时，请记住以下事实和概念:
    1.在变量中可以放置的所有东西都是对象，而每个对象都是类的实例。无论数字、函数和null都是对象。所有对象都继承自[Object]类。
    2.尽管Dart是强类型的，但类型声明是可选的，因为Dart可以推断类型。 在上面的代码中，数字被推断为int类型。 如果要明确说明不需要任何类型，请使用[特殊类型dynamic]。
    3.Dart支持通用类型，如List<int>(整数列表)或List<dynamic>(任何类型的对象列表)。
    4.Dart支持顶级函数(如main())，以及绑定到类或对象(分别是静态方法（static）和实例（instance）方法)的函数。您还可以在函数(嵌套或局部函数)中创建函数。
    5.类似地，Dart支持顶级变量，以及绑定到类或对象(静态和实例变量)的变量。实例变量有时被称为字段或属性。
    6.与Java不同，Dart没有公开、保护和私有的关键字。如果标识符以下划线(_)开头，则该标识符对其库是私有的。有关详细信息，请参见[库和可见性]。
    7.标识符可以以字母或下划线(_)开头，然后是这些字符加上数字的任何组合。
    8.有时候，某事物是一个表达（expression ）还是一个语句（statement）是很重要的，所以这两个词要准确。
    9.Dart工具可以报告两种问题:警告和错误。警告只是表明您的代码可能不工作，但它们不会阻止您的程序执行。错误可以是编译时错误，也可以是运行时错误。编译时错误阻止了代码的执行;运行时错误导致代码执行时引发异常。
    */