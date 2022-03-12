import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/Details/Details.dart';
import 'package:recipe_app/Details/DetailsDialog.dart';
import 'package:recipe_app/Search/Controller/recipeController.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:skeletons/skeletons.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key? key,
    required this.recipes,
    required this.currentIndex,
    required this.recipeController,
  }) : super(key: key);

  final List<RecipeModel> recipes;
  final int currentIndex;
  final RecipeController recipeController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool isDesktop = MediaQuery.of(context).size.width > 800;
        (isDesktop)
            ? showDialog(
                context: context,
                builder: (context) =>
                    DetailsDialog(recipe: recipes[currentIndex]))
            : Get.to(
                () => Details(
                  recipe: recipes[currentIndex],
                ),
              );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GridTile(
          child: Hero(
            tag: recipes[currentIndex].id!,
            child: CachedNetworkImage(
              imageUrl: recipes[currentIndex].image!,
              placeholder: (context, _) => SkeletonAvatar(),
            ),
          ),
          footer: GridTileBar(
            title: Text(recipes[currentIndex].title ?? ""),
            backgroundColor: Colors.black54,
            trailing: LikeButton(
              likeBuilder: (bool isLiked) {
                return Icon(
                  isLiked
                      ? Icons.bookmark_added_rounded
                      : Icons.bookmark_add_outlined,
                );
              },
              isLiked: recipes[currentIndex].isSaved,
              onTap: (bool isLiked) async {
                isLiked
                    ? recipeController.unsaveRecipe(recipes[currentIndex])
                    : recipeController.saveRecipe(recipes[currentIndex]);

                return !isLiked;
              },
            ),
          ),
        ),
      ),
    );
  }
}
