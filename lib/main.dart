import 'package:flutter/material.dart';
import 'screens/profile.dart';
import 'screens/login.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Login.route,
      routes: {
        Login.route: (context) => Login(),
        Home.route: (context) => Home(),
        Profile.route: (context) => Profile(),
    },
    );
  }

}

