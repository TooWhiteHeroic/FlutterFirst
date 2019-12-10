
//Dart是一种真正的面向对象语言，所以即使函数也是对象，具有类型和功能。这意味着函数可以分配给变量或作为参数传递给其他函数。您还可以像调用函数一样调用Dart类的实例
bool isNoble(int atomicNumber) {
  return atomicNumber != null;
}
isNoble2(atomicNumber){
  return atomicNumber != null;
}
//只包含一个函数的表达式
isNoble3(arg) => arg != null;
// =>expr 语法是 {return expr;} 的简写写法。“=>” 符号有时被称为胖箭头语法。
//注意:在箭头(=>)和分号(;)之间只能出现一个表达式(不是语句)。
//例如，您不能在那里放一个if语句，但是您可以使用一个条件表达式。

/*
    函数可以有两种类型的参数:必需的和可选的。首先列出必须的参数，后边是任何可选参数。命名可选参数也可以标记为@required
 */
//可选参数可以是命名参数也可以是位置参数，但不能包含两者，只能用其一
//定义命名参数 使用{param1, param2，…}来指定命名参数
//isBool({bool a,bool b}){...}
//调用命名参数 使用paramName: value来指定命名参数
//isBool(a=true,b=false);
/*
  Flutter实例创建表达式可能会变得复杂，因此小部件构造函数只使用命名参数。这使得实例创建表达式更容易阅读。
  您可以在任何Dart代码(不仅仅是Flutter)中注释一个已命名的参数，并使用@required说明它是一个必传的参数。例如:
  const Scrollbar({Key key, @required Widget child})
*/
//默认参数值
//函数可以使用 = 来定义命名和位置参数的默认值。默认值必须是编译时常量。如果没有提供默认值，则默认值为null。
String say(String from, String msg,
    [String device = 'carrier pigeon', String mood = 'MOOD']) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  if (mood != null) {
    result = '$result (in a $mood mood)';
  }
  return result;
}
void doStuff(
    {List<int> list = const [1, 2, 3],
      Map<String, String> gifts = const {
        'first': 'paper',
        'second': 'cotton',
        'third': 'leather'
      }}) {
  print('list:  $list');
  print('gifts: $gifts');
}
/*
void main() {
  querySelector('#sample_text_id')
    ..text = 'Click me!'
    ..onClick.listen(reverseText);
}
 */
//注意：代码前的 .. 语法被称为级联。使用级联，可以对单个对象的成员执行多个操作
void main(List<String> arguments){
  //可以使用args库来定义和解析命令行参数
  print(arguments);

  var list = [1, 2, 3];
  //可以将函数作为参数传递给另一个函数
  list.forEach(printElement);
  //为变量分配一个函数
  var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';


  print(isNoble(1));
  print(isNoble2(0));
  //  int lineCount;  未初始化的变量 默认值为null
  //  assert(lineCount == null);
  print(say("from", "MSG"));
  doStuff();

  //利用匿名函数
  var list1 = ['apples', 'bananas', 'oranges'];
  list1.forEach((item) {
    print('${list1.indexOf(item)}: $item');
  });
  //表达式
  list1.forEach(
          (item)=>print('${list1.indexOf(item)}: $item')
  );
}
void printElement(int element) {
  print(element);
}
/*
大多数函数都被命名，如main()或printElement()。你也可以创建一个没有函数名称的函数，这种函数称为匿名函数，或者lambda函数或者闭包函数。您可以为变量分配一个匿名函数，例如，您可以从集合中添加或删除它。

匿名函数看起来类似于命名函数--有0个或者多个参数，在括号之间用逗号和可选类型标注分隔。后面的代码块包含函数的主体:

([[Type] param1[, …]]) {
  codeBlock;
};
 */
//所有函数都返回一个值。如果没有指定返回值，则语句返回null;隐式附加到函数体



