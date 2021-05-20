import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// recipe model
import 'package:recipe_app/Search/Model/recipeModel.dart';

class Details extends StatefulWidget {
  final RecipeModel recipe;

  Details({Key? key, required this.recipe}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late YoutubePlayerController _vidController;

  @override
  void initState() {
    super.initState();
    var vidId =
        YoutubePlayerController.convertUrlToId(widget.recipe.youtubeVideo!);
    _vidController =
        YoutubePlayerController(initialVideoId: vidId ?? "tcodrIK2P_I");
  }

  @override
  void dispose() {
    _vidController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title ?? ""),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: widget.recipe.id!,
                transitionOnUserGestures: true,
                child: Image.network(
                  //TODO: put fallback image here
                  widget.recipe.image!,
                  fit: BoxFit.cover,
                  height: 250,
                  width: 500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ingredients:",
                              style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 8),
                          ...?_renderIngredientsList(widget.recipe),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Instructions:",
                              style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(widget.recipe.instructions ?? "",
                                style: Theme.of(context).textTheme.bodyText1),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Video:",
                              style: Theme.of(context).textTheme.headline5),
                          SizedBox(height: 8),
                          Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: YoutubePlayerIFrame(
                                controller: _vidController,
                                aspectRatio: 16 / 9,
                              )
                              // : Text("Waiting for video to initialize...")
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List? _renderIngredientsList(recipe) {
  return recipe.ingredients
      ?.map((ing) => ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://themealdb.com/images/ingredients/${ing.ingredient}.png"),
            ),
            title: Text(ing.ingredient ?? ""),
            subtitle: Text(ing.measure ?? ""),
          ))
      .toList();
}
