import 'package:flutter/material.dart';
import 'package:get/get.dart';

// core modules
import 'package:recipe_app/Details/Details.dart';
import 'package:recipe_app/Details/DetailsDialog.dart';
import 'package:recipe_app/Search/Controller/recipeController.dart';
import 'package:recipe_app/Search/Model/stateView.dart';
import 'package:recipe_app/Search/View/widgets/widgets.dart';
import 'package:skeletons/skeletons.dart';

class RecipesPage extends StatelessWidget {
  final RecipeController recipeController = Get.put(RecipeController());
  final String? query;

  RecipesPage({Key? key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        StateView status = recipeController.status.value;

        if (status == StateView.Error)
          return UserError(
            svgUrl: "assets/images/error_svg.svg",
            title: "Error",
            description: "Something went wrong\n Please try again.",
            btnText: "Try Again",
          );
        if (status == StateView.Empty)
          return UserError(
            svgUrl: "assets/images/notfound_svg.svg",
            title: "Not Found",
            description:
                "What you searched was\n unfortunately not found or doesn't exist.\n Try different keyword like\n 'chicken' or 'cake'",
            btnText: "Search Again",
          );

        List recipes = recipeController.recipes;

        return SkeletonTheme(
          shimmerGradient: LinearGradient(colors: [
            Colors.grey.shade300,
            Colors.grey.shade200,
            Colors.grey.shade200,
            Colors.grey.shade300,
          ]),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.search,
                      size: 32,
                    ),
                  )
                ],
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
                              "${query?.capitalize}",
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
                              "${recipes.length} results found",
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
                        for (int i = 0; i < recipes.length; i++)
                          GestureDetector(
                            onTap: () {
                              bool isDesktop =
                                  MediaQuery.of(context).size.width > 800;
                              (isDesktop)
                                  ? showDialog(
                                      context: context,
                                      builder: (context) =>
                                          DetailsDialog(recipe: recipes[i]))
                                  : Get.to(
                                      Details(
                                        recipe: recipes[i],
                                      ),
                                    );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GridTile(
                                child: Hero(
                                  tag: recipes[i].id!,
                                  child: Image.network(recipes[i].image!),
                                ),
                                //TODO: Find fallback image for this
                                footer: GridTileBar(
                                  title: Text(recipes[i].title ?? ""),
                                  backgroundColor: Colors.black54,
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.bookmark_add_rounded,
                                    ),
                                    onPressed: () {},
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
    );
  }
}
