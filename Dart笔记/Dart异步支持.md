# 异步

Dart库中有非常多的函数返回Future对象或Stream对象。这些函数是异步的：在可能耗时的操作(例如I/O)操作的语句之后不等到操作执行完成就返回。
async和await关键字支持异步编程，允许您编写类似于同步代码的异步代码。

## 处理Futures

当你需要一个完整的Futures的结果时，你有两个选择:

- 使用async和await
- 使用Future的API，如[库的引导]中描述的一样

使用async和await的代码虽然是异步的，但是看起来很像同步代码。例如，以下代码使用await来等待异步函数执行的结果：

```dart
await lookUpVersion();
```

要使用await必须是对一个使用async标注的异步函数：

```dart
Future checkVersion() async {
  var version = await lookUpVersion();
  // Do something with version
}
```

> 注意:尽管异步函数可能执行耗时的操作，但它不会等待这些操作。相反，异步函数一直执行直到遇到第一个await表达式([查看详细信息])。然后它返回一个Futures的对象，只有在await表达式完成之后才恢复执行。

Use try, catch, and finally to handle errors and cleanup in code that uses await:

使用try,catch和finally来处理使用await的代码中的错误：

```dart
try {
  version = await lookUpVersion();
} catch (e) {
  // React to inability to look up the version
}
```

你可以在异步函数中多次使用await。例如，以下代码执行了三次await来获取函数的结果。

```dart
var entrypoint = await findEntrypoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);
```

在await表达式中，表达式的值通常是一个Future对象。如果不是，那么这个值将被自动包装成Future。Futrue对象指示返回结果一定是一个对象。表达式的值就是被返回的对象。await表达式会让程序执行挂起，直到返回的对象可用。

***如果在使用await时出现编译时错误，请确保await在异步函数中*** 。例如，要在应用程序的main()函数中使用wait, main()的主体必须标记为async:

```dart
Future main() async {
  checkVersion();
  print('In main: version is ${await lookUpVersion()}');
}
```

## 声明异步函数

异步函数是函数体被用async修饰符标记的函数。
向函数中添加async关键字将使其返回一个Future。例如，请思考下例中返回一个字符串的同步函数:

```dart
String lookUpVersion() => '1.0.0';
```

如果你将他改变成一个异步函数，他的返回值将是一个Future：

```dart
Future<String> lookUpVersion() async => '1.0.0';
```

注意，函数的主体不需要使用Future的API。如果需要，Dart将创建Future的对象。
如果您的函数没有返回一个有用的值，那么将其返回Future<void>类型。

## 处理流(Stream)

当您需要从Stream获取值时，您有两个选择:

- 使用async和异步的for循环(await for)
- 使用Stream API，如[库的引导]中的描述

> 注意:在使用await for之前，请确保它使代码更清晰，并且您确实希望等待流（Stream）的所有结果。例如，您通常不应该为UI事件侦听器使用await，因为UI框架会发送无穷无尽的事件流。

异步for循环有以下形式:

```dart
await for (varOrType identifier in expression) {
  // Executes each time the stream emits a value.
}
```

表达式的值必须具有Stream类型。执行过程如下:

1. 等待流发出值。
2. 执行for循环的主体，并将变量设置为发出的值。
3. 重复1和2，直到流关闭。

要停止侦听流，您可以使用break或return语句，该语句将跳出for循环，并从流中取消订阅。

如果在实现异步for循环时出现编译时错误，请确保await在异步函数中。例如，要在应用程序的main()函数中使用异步For循环，main()的主体必须标记为async:

```dart
Future main() async {
  // ...
  await for (var request in requestServer) {
    handleRequest(request);
  }
  // ...
}
```

---

Dart类库有非常多的返回`Future`或者`Stream`对象的函数。 这些函数被称为**异步函数**：它们只会在设置好一些耗时操作之后返回，比如像 IO操作。而不是等到这个操作完成。

`async`和`await`关键词支持了异步编程，允许您写出和同步代码很像的异步代码。

## Future

`Future`与JavaScript中的`Promise`非常相似，表示一个异步操作的最终完成（或失败）及其结果值的表示。简单来说，它就是用于处理异步操作的，异步处理成功了就执行成功的操作，异步处理失败了就捕获错误或者停止后续操作。一个Future只会对应一个结果，要么成功，要么失败。

由于本身功能较多，这里我们只介绍其常用的API及特性。还有，请记住，`Future` 的所有API的返回值仍然是一个`Future`对象，所以可以很方便的进行链式调用。

#### Future.then

为了方便示例，在本例中我们使用`Future.delayed` 创建了一个延时任务（实际场景会是一个真正的耗时任务，比如一次网络请求），即2秒后返回结果字符串"hi world!"，然后我们在`then`中接收异步结果并打印结果，代码如下：

```dart
Future.delayed(new Duration(seconds: 2),(){
   return "hi world!";
}).then((data){
   print(data);
});
```

#### Future.catchError

如果异步任务发生错误，我们可以在`catchError`中捕获错误，我们将上面示例改为：

```dart
Future.delayed(new Duration(seconds: 2),(){
   //return "hi world!";
   throw AssertionError("Error");  
}).then((data){
   //执行成功会走到这里  
   print("success");
}).catchError((e){
   //执行失败会走到这里  
   print(e);
});
```

在本示例中，我们在异步任务中抛出了一个异常，`then`的回调函数将不会被执行，取而代之的是 `catchError`回调函数将被调用；但是，并不是只有 `catchError`回调才能捕获错误，`then`方法还有一个可选参数`onError`，我们也可以它来捕获异常：

```dart
Future.delayed(new Duration(seconds: 2), () {
    //return "hi world!";
    throw AssertionError("Error");
}).then((data) {
    print("success");
}, onError: (e) {
    print(e);
});
```

#### Future.whenComplete

有些时候，我们会遇到无论异步任务执行成功或失败都需要做一些事的场景，比如在网络请求前弹出加载对话框，在请求结束后关闭对话框。这种场景，有两种方法，第一种是分别在`then`或`catch`中关闭一下对话框，第二种就是使用`Future`的`whenComplete`回调，我们将上面示例改一下：

```dart
Future.delayed(new Duration(seconds: 2),(){
   //return "hi world!";
   throw AssertionError("Error");
}).then((data){
   //执行成功会走到这里 
   print(data);
}).catchError((e){
   //执行失败会走到这里   
   print(e);
}).whenComplete((){
   //无论成功或失败都会走到这里
});
```

#### Future.wait

有些时候，我们需要等待多个异步任务都执行结束后才进行一些操作，比如我们有一个界面，需要先分别从两个网络接口获取数据，获取成功后，我们需要将两个接口数据进行特定的处理后再显示到UI界面上，应该怎么做？答案是`Future.wait`，它接受一个`Future`数组参数，只有数组中所有`Future`都执行成功后，才会触发`then`的成功回调，只要有一个`Future`执行失败，就会触发错误回调。下面，我们通过模拟`Future.delayed` 来模拟两个数据获取的异步任务，等两个异步任务都执行成功时，将两个异步任务的结果拼接打印出来，代码如下：

```dart
Future.wait([
  // 2秒后返回结果  
  Future.delayed(new Duration(seconds: 2), () {
    return "hello";
  }),
  // 4秒后返回结果  
  Future.delayed(new Duration(seconds: 4), () {
    return " world";
  })
]).then((results){
  print(results[0]+results[1]);
}).catchError((e){
  print(e);
});
```

执行上面代码，4秒后你会在控制台中看到“hello world”。

### Async/await

Dart中的`async/await` 和JavaScript中的`async/await`功能和用法是一模一样的，如果你已经了解JavaScript中的`async/await`的用法，可以直接跳过本节。

#### 回调地狱(Callback Hell)

如果代码中有大量异步逻辑，并且出现大量异步任务依赖其它异步任务的结果时，必然会出现`Future.then`回调中套回调情况。举个例子，比如现在有个需求场景是用户先登录，登录成功后会获得用户ID，然后通过用户ID，再去请求用户个人信息，获取到用户个人信息后，为了使用方便，我们需要将其缓存在本地文件系统，代码如下：

```dart
//先分别定义各个异步任务
Future<String> login(String userName, String pwd){
    ...
    //用户登录
};
Future<String> getUserInfo(String id){
    ...
    //获取用户信息 
};
Future saveUserInfo(String userInfo){
    ...
    // 保存用户信息 
};
```

接下来，执行整个任务流：

```dart
login("alice","******").then((id){
 //登录成功后通过，id获取用户信息    
 getUserInfo(id).then((userInfo){
    //获取用户信息后保存 
    saveUserInfo(userInfo).then((){
       //保存用户信息，接下来执行其它操作
        ...
    });
  });
})
```

可以感受一下，如果业务逻辑中有大量异步依赖的情况，将会出现上面这种在回调里面套回调的情况，过多的嵌套会导致的代码可读性下降以及出错率提高，并且非常难维护，这个问题被形象的称为**回调地狱（Callback Hell）**。回调地狱问题在之前JavaScript中非常突出，也是JavaScript被吐槽最多的点，但随着ECMAScript6和ECMAScript7标准发布后，这个问题得到了非常好的解决，而解决回调地狱的两大神器正是ECMAScript6引入了`Promise`，以及ECMAScript7中引入的`async/await`。 而在Dart中几乎是完全平移了JavaScript中的这两者：`Future`相当于`Promise`，而`async/await`连名字都没改。接下来我们看看通过`Future`和`async/await`如何消除上面示例中的嵌套问题。

##### 使用Future消除Callback Hell

```dart
login("alice","******").then((id){
      return getUserInfo(id);
}).then((userInfo){
    return saveUserInfo(userInfo);
}).then((e){
   //执行接下来的操作 
}).catchError((e){
  //错误处理  
  print(e);
});
```

正如上文所述， *“Future 的所有API的返回值仍然是一个Future对象，所以可以很方便的进行链式调用”* ，如果在then中返回的是一个`Future`的话，该`future`会执行，执行结束后会触发后面的`then`回调，这样依次向下，就避免了层层嵌套。

##### 使用async/await消除callback hell

通过`Future`回调中再返回`Future`的方式虽然能避免层层嵌套，但是还是有一层回调，有没有一种方式能够让我们可以像写同步代码那样来执行异步任务而不使用回调的方式？答案是肯定的，这就要使用`async/await`了，下面我们先直接看代码，然后再解释，代码如下：

```dart
task() async {
   try{
    String id = await login("alice","******");
    String userInfo = await getUserInfo(id);
    await saveUserInfo(userInfo);
    //执行接下来的操作   
   } catch(e){
    //错误处理   
    print(e);   
   }  
}
```

- `async`用来表示函数是异步的，定义的函数会返回一个`Future`对象，可以使用then方法添加回调函数。
- `await` 后面是一个`Future`，表示等待该异步任务完成，异步完成后才会往下走；`await`必须出现在 `async`函数内部。

可以看到，我们通过`async/await`将一个异步流用同步的代码表示出来了。

> 其实，无论是在JavaScript还是Dart中，`async/await`都只是一个语法糖，编译器或解释器最终都会将其转化为一个Promise（Future）的调用链。

## Stream

`Stream` 也是用于接收异步事件数据，和`Future` 不同的是，它可以接收多个异步操作的结果（成功或失败）。 也就是说，在执行异步任务时，可以通过多次触发成功或失败事件来传递结果数据或错误异常。 `Stream` 常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等。举个例子：

```dart
Stream.fromFutures([
  // 1秒后返回结果
  Future.delayed(new Duration(seconds: 1), () {
    return "hello 1";
  }),
  // 抛出一个异常
  Future.delayed(new Duration(seconds: 2),(){
    throw AssertionError("Error");
  }),
  // 3秒后返回结果
  Future.delayed(new Duration(seconds: 3), () {
    return "hello 3";
  })
]).listen((data){
   print(data);
}, onError: (e){
   print(e.message);
},onDone: (){

});
```

上面的代码依次会输出：

```
I/flutter (17666): hello 1
I/flutter (17666): Error
I/flutter (17666): hello 3
```

代码很简单，就不赘述了。