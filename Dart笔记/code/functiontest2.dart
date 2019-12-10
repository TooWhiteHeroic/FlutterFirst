//词法闭包
//闭包是一个函数对象，它可以访问其词法范围内的变量，即使函数在其原始范围之外使用。
//
//函数可以关闭周围作用域中定义的变量。在下面的示例中，makeAdder()捕获变量addBy。无论返回的函数到哪里，它都会记住addBy。

//Function makeAdder(num addBy) {
//  return (num i) => addBy + i;
//}
//
//void main() {
//  // Create a function that adds 2.
//  var add2 = makeAdder(2);
//
//  // Create a function that adds 4.
//  var add4 = makeAdder(4);
//
//  assert(add2(3) == 5);
//  assert(add4(3) == 7);
//}

void foo() {} // A top-level function

class A {
  static void bar() {} // A static method
  void baz() {} // An instance method
}

void main() {
  var x;

  // Comparing top-level functions.
  x = foo;
  assert(foo == x);

  // Comparing static methods.
  x = A.bar;
  assert(A.bar == x);

  // Comparing instance methods.
  var v = A(); // Instance #1 of A
  var w = A(); // Instance #2 of A
  var y = w;
  x = w.baz;

  assert(y.baz == x);

  assert(v.baz != w.baz);
}