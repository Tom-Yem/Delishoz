import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_app/Details/Details.dart';
import 'package:recipe_app/Details/DetailsDialog.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:skeletons/skeletons.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard(
      {Key? key,
      required this.savedRecipes,
      required this.currentIndex,
      required this.tempUnsavedRecipes})
      : super(key: key);

  final List savedRecipes;
  final int currentIndex;
  final RxList<RecipeModel> tempUnsavedRecipes;

  bool isUnsaved(RecipeModel rec) =>
      tempUnsavedRecipes.any((element) => element.id == rec.id);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool isDesktop = MediaQuery.of(context).size.width > 800;
        (isDesktop)
            ? showDialog(
                context: context,
                builder: (context) =>
                    DetailsDialog(recipe: savedRecipes[currentIndex]))
            : Get.to(
                () => Details(
                  recipe: savedRecipes[currentIndex],
                ),
              );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: GridTile(
          child: Hero(
            tag: savedRecipes[currentIndex].id!,
            child: CachedNetworkImage(
              imageUrl: savedRecipes[currentIndex].image!,
              placeholder: (context, _) => SkeletonAvatar(),
            ),
          ),
          footer: GridTileBar(
            title: Text(savedRecipes[currentIndex].title ?? ""),
            backgroundColor: Colors.black54,
            trailing: LikeButton(
              likeBuilder: (bool isLiked) {
                return Icon(isLiked
                    ? Icons.bookmark_added_rounded
                    : Icons.bookmark_add_outlined);
              },
              isLiked: !isUnsaved(savedRecipes[currentIndex]),
              onTap: (bool isLiked) async {
                isLiked
                    ? tempUnsavedRecipes.add(savedRecipes[currentIndex])
                    : tempUnsavedRecipes.removeWhere((element) =>
                        element.id == savedRecipes[currentIndex].id);

                return !isLiked;
              },
            ),
          ),
        ),
      ),
    );
  }
}
