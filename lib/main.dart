import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Homepage view
import 'package:recipe_app/Home/View/HomePage.dart';
import 'package:recipe_app/hive_adapters/ingredient_adapter.dart';
import 'package:recipe_app/hive_adapters/recipe_adapter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(IngredientHiveAdapter());
  Hive.registerAdapter(RecipeHiveAdapter());
  await Hive.openBox("saved");

  // make system bottom navigation bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
    ),
  );

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
