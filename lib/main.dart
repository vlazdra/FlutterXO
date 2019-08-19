import 'package:flutter/material.dart';
import 'package:flutter_xo/screens/login_screen.dart';
import 'package:flutter_xo/screens/main_screen.dart';
import 'package:flutter_xo/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', initialRoute: '/', routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => SplashScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/login': (context) => LoginScreen(),
      '/main': (context) => MainScreen(),
    });
  }
}
