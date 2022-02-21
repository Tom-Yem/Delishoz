import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// core modules
import 'package:recipe_app/Search/Controller/recipeController.dart';
import 'package:recipe_app/Search/View/Recipes.dart';
import 'package:recipe_app/Saved/Saved.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});

  final String? title;
  final RecipeController recipeController = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "$title",
              style: GoogleFonts.pattaya(fontSize: 32),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.bookmarks_rounded),
                onPressed: () {
                  recipeController.getSavedRecipes();
                  Get.to(() => Saved());
                },
              )
            ],
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/home_wallpaper.jpg"),
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
                            .headline4
                            ?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              onSubmitted: (input) {
                                recipeController.searchMeal(input);
                                Get.to(
                                  () => RecipesPage(),
                                );
                              },
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 32,
                                    color: Colors.white,
                                  ),
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
                                  filled: true,
                                  fillColor: Colors.black54,
                                  labelStyle: TextStyle(color: Colors.white)),
                            ),
                          ),
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
