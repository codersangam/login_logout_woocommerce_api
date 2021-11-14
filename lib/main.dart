import 'package:flutter/material.dart';
import 'package:login/screens/homepage.dart';
import 'package:login/screens/login_page.dart';
import 'package:login/services/shared_service.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await SharedService.isLoggedIn();
  if (isLoggedIn) {
    _defaultHome = const HomePage();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wordpress Login/Logout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const HomePage(),
        '/login': (BuildContext context) => const LoginPage(),
      },
    );
  }
}
