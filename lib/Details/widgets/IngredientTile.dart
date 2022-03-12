import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:skeletons/skeletons.dart';

class IngredientTile extends StatelessWidget {
  const IngredientTile({Key? key, required this.ingredientContainer})
      : super(key: key);

  final Ingredient ingredientContainer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: CachedNetworkImage(
          width: 40,
          height: 40,
          imageUrl:
              "https://themealdb.com/images/ingredients/${ingredientContainer.ingredient}.png",
          placeholder: (context, url) => SkeletonAvatar(
            style: SkeletonAvatarStyle(
              shape: BoxShape.circle,
            ),
          ),
          errorWidget: (context, url, error) {
            print("🧨🧨🎊🎍🎋$error");
            return CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.error,
                color: Colors.grey.shade500,
              ),
            );
          },
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Tooltip(
          message: ingredientContainer.ingredient ?? "",
          child: Text(
            ingredientContainer.ingredient ?? "",
            style: TextStyle(overflow: TextOverflow.ellipsis),
            maxLines: 1,
          ),
        ),
      ),
      trailing: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 120),
        child: Tooltip(
          message: ingredientContainer.measure ?? "",
          child: Text(
            ingredientContainer.measure ?? "",
            textAlign: TextAlign.end,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}
