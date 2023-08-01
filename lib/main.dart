import 'package:eventhub/user/user_home.dart';
import 'package:eventhub/user/user_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'connect.dart';
import 'home.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key,});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var log=true;
  bool? isLoggedIn = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:
      isLoggedIn==true ? '/home':'/login' , // Set initial route based on the isLoggedIn flag
      routes: {
        '/home': (context) => user_home(),
        '/login': (context) => home(),
      },
      theme: ThemeData(
        canvasColor: Colors.black,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.black
        )
      ),
      home: home(),
      debugShowCheckedModeBanner: false,

    );
  }
}


