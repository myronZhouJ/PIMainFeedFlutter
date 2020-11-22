import 'package:flutter/material.dart';


class PILayoutDM extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PILayoutDMPage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PILayoutDMPage(title: 'LayoutDM'),
    );
  }
}

class PILayoutDMPage extends StatelessWidget {
  PILayoutDMPage({this.title});
  final String title;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BlueBox(),
              BlueBox(),
              Spacer(flex: 1),
              BlueBox(),
              Spacer(flex: 2),
              BlueBox(),
            ],
          ),
        )
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}