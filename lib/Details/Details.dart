import 'package:flutter/material.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// recipe model
import 'package:recipe_app/Search/Model/recipeModel.dart';

class Details extends StatefulWidget {
  final RecipeModel recipe;

  Details({Key? key, required this.recipe}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // late YoutubePlayerController _vidController;
  late ScrollController _scrollController;
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    // intialize scroll controller
    _scrollController = ScrollController()
      ..addListener(
        () {
          setState(() {
            scrollOffset = _scrollController.offset;
          });
        },
      );
    // intialize video controller
    // var vidId =
    //     YoutubePlayerController.convertUrlToId(widget.recipe.youtubeVideo!);
    // _vidController =
    //     YoutubePlayerController(initialVideoId: vidId ?? "tcodrIK2P_I");
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // _vidController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.recipe.title ?? ""),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF141f29)
            .withOpacity((scrollOffset / 250).clamp(0, 1).toDouble()),
      ),
      body: Container(
        child: SingleChildScrollView(
          controller: _scrollController,
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
                          // Padding(
                          //     padding: const EdgeInsets.only(left: 16.0),
                          //     child: YoutubePlayerIFrame(
                          //       controller: _vidController,
                          //       aspectRatio: 16 / 9,
                          //     )
                          //     // : Text("Waiting for video to initialize...")
                          //     ),
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
