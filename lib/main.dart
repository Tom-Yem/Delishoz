import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Homepage view
import 'package:recipe_app/Home/View/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // TODO: Clean primary swatch part
        primarySwatch: MaterialColor(
          0xFF141f29,
          {
            50: Color.fromRGBO(20, 31, 41, 1),
            100: Color.fromRGBO(20, 31, 41, 1),
            200: Color.fromRGBO(20, 31, 41, 1),
            300: Color.fromRGBO(20, 31, 41, 1),
            400: Color.fromRGBO(20, 31, 41, 1),
            500: Color.fromRGBO(20, 31, 41, 1),
            600: Color.fromRGBO(20, 31, 41, 1),
            700: Color.fromRGBO(20, 31, 41, 1),
            800: Color.fromRGBO(20, 31, 41, 1),
            900: Color.fromRGBO(20, 31, 41, 1),
          },
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: "/",
      getPages: [GetPage(name: "/", page: () => MyHomePage(title: 'Delishoz'))],
    );
  }
}
