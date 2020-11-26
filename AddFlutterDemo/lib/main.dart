import 'package:flutter/material.dart';
import 'dart:ui' as ui; // 调用window拿到route判断跳转哪个界面

import 'PIFlutterPA.dart';
import 'PIHome/PIMainFeed.dart';

void main() {
  return runApp(jumpToRoute(ui.window.defaultRouteName));
}


Widget jumpToRoute(String route) {
  switch (route) {
    case 'PIFlutterPA':
      return PIFlutterPageA();
    default:
//      return PICounter.run();
      return PIMainFeedApp();
  }
}