import 'package:flutter/material.dart';
import 'package:retrendfinal/storepage.dart';
import 'firstscreen.dart';
import 'storepage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retrend',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
         primaryColor: Color(0xff6666ff),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.black)

        )
      ),
      home: FirstScreen(),
    );
  }
}
