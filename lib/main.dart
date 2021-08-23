import 'package:flutter/material.dart';
import 'package:Quotify/ui/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        backgroundColor: Color(0xfff8ede3),
        primaryColor: Color(0xff798777),
        accentColor: Color(0xffbdd2b6),
        splashColor: Color(0xffA2B29F),
        appBarTheme: AppBarTheme(
            backgroundColor: Color(0xfff8ede3),
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xff798777)),
            actionsIconTheme: IconThemeData(color: Color(0xff798777))),
        iconTheme: IconThemeData(color: Colors.black),
        // Define the default font family.
        fontFamily: 'Raleway',
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                onPrimary: Color(0xff798777),
                primary: Color(0xffA2B29F),
                onSurface: Color(0xff798777),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.black, fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(color: Color(0xff798777), fontSize: 36.0, fontWeight: FontWeight.w500),
          bodyText1: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Raleway', letterSpacing: 0.3),
          bodyText2: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Raleway', letterSpacing: 0.3),
        ),
      ),
      home: Home(),
    );
  }
}
