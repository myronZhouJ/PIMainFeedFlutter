import 'package:flutter/material.dart';
import 'dart:ui' as ui; // 调用window拿到route判断跳转哪个界面

import 'PIFlutterPA.dart';
import 'PIFlutterPB.dart';
import 'PIStore.dart';
import 'PICounter.dart';
import 'PIHome/PIMainFeed.dart';
import 'PILayoutDM.dart';



void main() => runApp(jumpToRoute(ui.window.defaultRouteName));

Widget jumpToRoute(String route) {
  switch (route) {
    case 'PIFlutterPA':
      return PIFlutterPageA();
    case 'PIFlutterPB':
      return PIFlutterPageB();
    case 'PIFlutterStore':
      return PIStore.run();
    default:
//      return PICounter.run();
//      return PILayoutDM();
      return PIMainFeedApp();
  }
}


//@pragma('vm:entry-point')
//void pIFlutterPA(){
//  PIFlutterPA.run();
//}
//@pragma('vm:entry-point')
//void pIFlutterPB(){
//  PIFlutterPB.run();
//}