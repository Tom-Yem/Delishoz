import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/Details/Details.dart';
import 'package:recipe_app/Details/DetailsDialog.dart';
import 'package:recipe_app/Search/Controller/recipeController.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:recipe_app/Search/Model/stateView.dart';
import 'package:skeletons/skeletons.dart';

import '../Search/View/widgets/widgets.dart';

class Saved extends StatelessWidget {
  Saved({Key? key}) : super(key: key);

  RecipeController _recipeController = Get.find<RecipeController>();
  RxList<RecipeModel> tempUnsavedRecipes = <RecipeModel>[].obs;

  bool isUnsaved(RecipeModel rec) =>
      tempUnsavedRecipes.any((element) => element.id == rec.id);

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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        status == StateView.Loading
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                    lines: 1,
                                  ),
                                ),
                              )
                            : Text(
                                "Saved",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                              ),
                        status == StateView.Loading
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                    lines: 1,
                                  ),
                                ),
                              )
                            : Text(
                                "${savedRecipes.length} items",
                                style: Theme.of(context).textTheme.caption,
                              ),
                      ],
                    ),
                  ),
                ),
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
                            GestureDetector(
                              onTap: () {
                                bool isDesktop =
                                    MediaQuery.of(context).size.width > 800;
                                (isDesktop)
                                    ? showDialog(
                                        context: context,
                                        builder: (context) => DetailsDialog(
                                            recipe: savedRecipes[i]))
                                    : Get.to(
                                        () => Details(
                                          recipe: savedRecipes[i],
                                        ),
                                      );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GridTile(
                                  child: Hero(
                                    tag: savedRecipes[i].id!,
                                    child:
                                        Image.network(savedRecipes[i].image!),
                                  ),
                                  //TODO: Find fallback image for this
                                  footer: GridTileBar(
                                    title: Text(savedRecipes[i].title ?? ""),
                                    backgroundColor: Colors.black54,
                                    trailing: LikeButton(
                                      likeBuilder: (bool isLiked) {
                                        return Icon(isLiked
                                            ? Icons.bookmark_added_rounded
                                            : Icons.bookmark_add_outlined);
                                      },
                                      isLiked: !isUnsaved(savedRecipes[i]),
                                      onTap: (bool isLiked) async {
                                        isLiked
                                            ? tempUnsavedRecipes
                                                .add(savedRecipes[i])
                                            : tempUnsavedRecipes.removeWhere(
                                                (element) =>
                                                    element.id ==
                                                    savedRecipes[i].id);

                                        return !isLiked;
                                      },
                                    ),
                                  ),
                                ),
                              ),
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
