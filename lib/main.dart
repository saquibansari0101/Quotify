import 'package:Quotify/database/app_database.dart';
import 'package:Quotify/database/quote_dao.dart';
import 'package:flutter/material.dart';
import 'package:Quotify/ui/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  final dao = database.quoteDao;
  runApp(MyApp(dao));
}

class MyApp extends StatelessWidget {
  final QuoteDao quoteDao;

  const MyApp(this.quoteDao);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(color: Colors.black, fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(color: Color(0xff798777), fontSize: 36.0, fontWeight: FontWeight.w500),
            bodyText1: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
                letterSpacing: 0.3),
            bodyText2: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
                letterSpacing: 0.3),
            caption: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
                letterSpacing: 0.3),
            button: TextStyle(color: Color(0xfff8ede3), fontSize: 20, fontFamily: 'Raleway'),
            subtitle1: TextStyle(fontWeight:FontWeight.bold,fontSize: 30, color: Color(0xffA2B29F), fontFamily: 'Raleway'),
            subtitle2:
                TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff727272), fontFamily: 'Raleway'),
          ),
          snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          errorColor: Colors.red),
      home: Home(quoteDao),
    );
  }
}
