import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      getPages: [GetPage(name: "/", page: () => MyHomePage(title: 'Home'))],
    );
  }
}
