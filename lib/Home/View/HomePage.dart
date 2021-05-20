import 'package:flutter/material.dart';
import 'package:get/get.dart';

// core modules
import 'package:recipe_app/Search/Controller/recipeController.dart';
import 'package:recipe_app/Search/View/Recipes.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});

  final String? title;
  final TextEditingController _controller = TextEditingController();
  final RecipeController recipeController = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(title: Text("$title")),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("/home_wallpaper.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.6),
              ),
              Center(
                child: Container(
                  width: 500,
                  height: 500,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Search it, Make it, \nEat it!",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: Colors.white),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              controller: _controller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelText: "Search",
                                  // filled: true,
                                  // fillColor: Colors.black3,
                                  labelStyle: TextStyle(color: Colors.white)),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 18))),
                            onPressed: () {
                              recipeController.searchMeal(_controller.text);
                              // Get.toNamed("/search");
                              Get.to(RecipesPage());
                            },
                            child: Icon(
                              Icons.search,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
