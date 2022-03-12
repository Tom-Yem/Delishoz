import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/Details/Details.dart';
import 'package:recipe_app/Details/DetailsDialog.dart';
import 'package:recipe_app/Saved/widgets/widgets.dart';
import 'package:recipe_app/Search/Controller/recipeController.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:recipe_app/Search/Model/stateView.dart';
import 'package:skeletons/skeletons.dart';

import '../Search/View/widgets/widgets.dart';

class Saved extends StatelessWidget {
  Saved({Key? key}) : super(key: key);

  final RecipeController _recipeController = Get.find<RecipeController>();
  RxList<RecipeModel> tempUnsavedRecipes = <RecipeModel>[].obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        for (var r in tempUnsavedRecipes) {
          _recipeController.unsaveRecipe(r);
        }
        tempUnsavedRecipes.clear();
        return true;
      },
      child: Scaffold(
        body: Obx(() {
          StateView status = _recipeController.status2.value;
          List savedRecipes = _recipeController.savedRecipes;

          if (status == StateView.Error)
            return UserError(
              svgUrl: "assets/images/error_svg.svg",
              title: "Error",
              description: "Something went wrong\n Please try again.",
              btnText: "Try Again",
              btnAction: () {
                _recipeController.getSavedRecipes();
              },
            );
          if (status == StateView.Empty)
            return UserError(
              svgUrl: "assets/images/notfound_svg.svg",
              title: "Empty",
              description:
                  "You do not have saved recipes. Go back and save some!",
              btnText: "Go Back",
              btnAction: () {
                Get.back();
              },
            );

          return SkeletonTheme(
            shimmerGradient: LinearGradient(
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade200,
                Colors.grey.shade200,
                Colors.grey.shade300,
              ],
            ),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                HeaderSection(status: status, savedRecipes: savedRecipes),
                SliverGrid.count(
                  crossAxisCount:
                      MediaQuery.of(context).size.width <= 800 ? 2 : 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: status == StateView.Loading
                      ? List.generate(
                          10,
                          (index) => SkeletonAvatar(),
                        )
                      : [
                          for (int i = 0; i < savedRecipes.length; i++)
                            IngredientCard(
                              savedRecipes: savedRecipes,
                              currentIndex: i,
                              tempUnsavedRecipes: tempUnsavedRecipes,
                            )
                        ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
