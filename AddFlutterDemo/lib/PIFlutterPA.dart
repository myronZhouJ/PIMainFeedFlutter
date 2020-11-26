import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class PIFlutterPageA extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'PIFlutterPA Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _batteryLevel;
  static const _methodChannel = const MethodChannel('example.methodChannel');
  static const _eventChannel = const EventChannel('example.eventChannel');
  static const _basicMessageChannel = BasicMessageChannel('example.basicMessageChannel', StringCodec());

  _MyHomePageState(){
    _methodChannel.setMethodCallHandler((MethodCall methodCall) async {
      String methodName = methodCall.method;            // 方法名
      Map params = methodCall.arguments;                // 参数
      Map<String, String> resultMap = Map();            // 返回结果
      switch(methodName) {
        case "flutter_display_user_info":      // 登录
          print("flutter_display_user_info:${params}");
          break;
        default:
      }
      return resultMap;
    });

    _eventChannel.receiveBroadcastStream().listen((dynamic data) {
      //更新状态
      setState(() {
        var privateString = data.toString();
        print('_getEventChData:$privateString');
      });
    }, onError: (Object err) {

    });

    _basicMessageChannel.setMessageHandler((String message) async {
      print('Received from iOS: $message');
      var prefix = 'Hello-';
      var value = int.parse(message.substring(prefix.length)) + 1;
      return prefix + value.toString();
    });
  }

  // 调用原生方法，方法名为getBatteryLevel
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      // result是原生获取到电池电量后传递过来的
      final int result = await _methodChannel.invokeMethod('batteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  //调用原生 signIn
  void _signIn(){
    _methodChannel.invokeMethod('signIn');
  }

  void _seeHello(){
    _basicMessageChannel.send('Hello iOS');
  }

  //---------------------------------------------
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
            RaisedButton(
              child: Text('Sign in'),
              onPressed: _signIn,
            ),
            RaisedButton(
              child: Text('See Hello'),
              onPressed: _seeHello,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
