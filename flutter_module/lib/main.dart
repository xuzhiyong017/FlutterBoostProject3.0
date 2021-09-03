import 'package:flutter/material.dart';
import 'package:flutter_boost/boost_flutter_binding.dart';
import 'package:flutter_boost/boost_navigator.dart';
import 'package:flutter_boost/flutter_boost_app.dart';
import 'package:flutter_module/pages/dialog_page.dart';
import 'package:flutter_module/pages/lifecycle_test_page.dart';
import 'package:flutter_module/pages/main_page.dart';
import 'package:flutter_module/pages/replacement_page.dart';
import 'package:flutter_module/pages/simple_page.dart';

class CustomFlutterBinding extends WidgetsFlutterBinding with BoostFlutterBinding {

}

void main(){
  //在runApp之前确保BoostFlutterBinding初始化
  CustomFlutterBinding();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///路由表
  static Map<String, FlutterBoostRouteFactory> routerMap = {
    'homePage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) {
            Map<String, Object> map = settings.arguments;
            String data = map['data'];
            return MainPage(
              data: data,
            );
          });
    },
    'simplePage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___){
            Map<String, Object> map = settings.arguments;
            String data = map['data'];
            return SimplePage(
              data: data,
            );
          });
    },

    ///生命周期例子页面
    'lifecyclePage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => LifecycleTestPage());
    },
    'replacementPage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(
          settings: settings, pageBuilder: (_, __, ___) => ReplacementPage());
    },

    ///透明弹窗页面
    'dialogPage': (settings, uniqueId) {
      return PageRouteBuilder<dynamic>(

        ///透明弹窗页面这个需要是false
          opaque: false,

          ///背景蒙版颜色
          barrierColor: Colors.black12,
          settings: settings,
          pageBuilder: (_, __, ___) => DialogPage());
    },
  };

  Route<dynamic> routeFactory(RouteSettings settings, String uniqueId) {
    FlutterBoostRouteFactory func = routerMap[settings.name];
    if (func == null) {
      return null;
    }
    return func(settings, uniqueId);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterBoostApp(routeFactory);
  }
}