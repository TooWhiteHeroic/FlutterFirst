//词法作用域
//Dart是一种在词法上确定范围的语言，这意味着变量的范围是静态的，仅仅是通过代码的布局来决定的。您可以“跟随花括号向外”以查看变量是否在范围内。
bool topLevel = true;

void main() {
  var insideMain = true;
  //print(myFunction.insideFunction);
  //下取上  上不访下
  void myFunction() {
    var insideFunction = true;
    void nestedFunction() {
      var insideNestedFunction = true;

      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }
}