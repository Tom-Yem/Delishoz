import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/Details/Details.dart';
import 'package:recipe_app/Details/DetailsDialog.dart';
import 'package:recipe_app/Search/Controller/recipeController.dart';
import 'package:recipe_app/Search/Model/stateView.dart';
import 'package:skeletons/skeletons.dart';

class Saved extends StatelessWidget {
  Saved({Key? key}) : super(key: key);

  RecipeController _recipeController = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        StateView status = _recipeController.status.value;
        List savedRecipes = _recipeController.savedRecipes;

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
                      Text(
                        "Saved",
                        style: Theme.of(context).textTheme.headline5?.copyWith(
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
                                // bool isDesktop =
                                //     MediaQuery.of(context).size.width > 800;
                                // (isDesktop)
                                //     ? showDialog(
                                //         context: context,
                                //         builder: (context) =>
                                //             DetailsDialog(recipe: savedRecipes[i]))
                                //     : Get.to(
                                //         () => Details(
                                //           recipe: savedRecipes[i],
                                //         ),
                                //       );
                              },
                              child: Text("${savedRecipes[i]}")
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(8),
                              //   child: GridTile(
                              //     child: Hero(
                              //       tag: savedRecipes[i].id!,
                              //       child: Image.network(savedRecipes[i].image!),
                              //     ),
                              //     //TODO: Find fallback image for this
                              //     footer: GridTileBar(
                              //       title: Text(savedRecipes[i].title ?? ""),
                              //       backgroundColor: Colors.black54,
                              //       trailing: IconButton(
                              //         icon: Icon(
                              //           Icons.bookmark_add_rounded,
                              //         ),
                              //         onPressed: () {},
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              )
                      ],
              )
            ],
          ),
        );
      }),
    );
  }
}
