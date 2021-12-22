import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:recipe_app/Search/Model/recipeModel.dart';

class DetailsDialog extends StatefulWidget {
  final RecipeModel recipe;

  const DetailsDialog({Key? key, required this.recipe}) : super(key: key);

  @override
  _DetailsDialogState createState() => _DetailsDialogState();
}

class _DetailsDialogState extends State<DetailsDialog> {
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
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: 700,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.recipe.id!,
                    transitionOnUserGestures: true,
                    child: Image.network(
                        //TODO: put fallback image here
                        widget.recipe.image!,
                        fit: BoxFit.cover,
                        height: 250,
                        width: MediaQuery.of(context).size.width),
                  ),
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    alignment: Alignment.bottomCenter,
                    child: Text(widget.recipe.title ?? "",
                        style: Theme.of(context).primaryTextTheme.headline6),
                  )
                ],
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
