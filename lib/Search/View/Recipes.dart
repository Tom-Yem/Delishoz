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

  RecipesPage({
    Key? key,
  }) : super(key: key);

  Rx<bool> searchIconVisible = true.obs;

  void toggleSearchIcon({required bool isVisible}) {
    searchIconVisible(isVisible);
  }

  // controlls focus for search field
  FocusNode focusNode = FocusNode();

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
            btnAction: () {
              recipeController.searchMeal(recipeController.query.value);
            },
          );
        if (status == StateView.Empty)
          return UserError(
            svgUrl: "assets/images/notfound_svg.svg",
            title: "Not Found",
            description:
                "What you searched was\n unfortunately not found or doesn't exist.\n Try different keyword like\n 'chicken' or 'cake'",
            btnText: "Search Again",
            btnAction: () {
              // go back to succes state
              recipeController.status(StateView.Success);

              toggleSearchIcon(isVisible: false);
              focusNode.requestFocus();
            },
          );

        List recipes = recipeController.recipes;

        return SkeletonTheme(
          shimmerGradient: LinearGradient(
            colors: [
              Colors.grey.shade300,
              Colors.grey.shade200,
              Colors.grey.shade200,
              Colors.grey.shade300,
            ],
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            onLongPress: () => toggleSearchIcon(isVisible: true),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: LayoutBuilder(
                      builder: ((context, constraints) => AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: searchIconVisible.value
                                ? 0
                                : constraints.maxWidth,
                            child: TextField(
                              focusNode: focusNode,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (input) {
                                recipeController.searchMeal(input);
                                toggleSearchIcon(isVisible: true);
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'Search',
                                filled: true,
                                fillColor: Colors.grey.shade300,
                              ),
                            ),
                          )),
                    ),
                  ),
                  actions: [
                    if (searchIconVisible.value)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 32,
                          ),
                          onPressed: () {
                            toggleSearchIcon(isVisible: false);
                          },
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
                                "${recipeController.query.value.capitalize}",
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
          ),
        );
      }),
    );
  }
}
