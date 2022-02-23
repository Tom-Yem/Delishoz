import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// recipe model
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:skeletons/skeletons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Details extends StatefulWidget {
  final RecipeModel recipe;

  Details({Key? key, required this.recipe}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late YoutubePlayerController _vidController;
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
    var vidId = YoutubePlayer.convertUrlToId(widget.recipe.youtubeVideo!);
    _vidController = YoutubePlayerController(
      initialVideoId: vidId ?? "w9uWPBDHEKE",
      flags: YoutubePlayerFlags(autoPlay: false),
    );
    // print("vidId:$vidId");
  }

  @override
  void deactivate() {
    _vidController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _vidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.recipe.title ?? "";

    return SkeletonTheme(
      shimmerGradient: LinearGradient(
        colors: [
          Colors.grey.shade300,
          Colors.grey.shade200,
          Colors.grey.shade200,
          Colors.grey.shade300,
        ],
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height / 3,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(title),
                centerTitle: true,
                background: Hero(
                  tag: widget.recipe.id!,
                  transitionOnUserGestures: true,
                  child: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(color: Colors.black26),
                    child: Image.network(
                        //TODO: put fallback image here
                        widget.recipe.image!,
                        fit: BoxFit.cover,
                        height: 250,
                        width: MediaQuery.of(context).size.width),
                  ),
                ),
              ),
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.only(right: 8.0),
              //     child: Icon(Icons.bookmark_add_rounded),
              //   ),
              // ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ingredients",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    ...?_renderIngredientsList(widget.recipe, context),
                    SizedBox(height: 24),
                    Text(
                      "Directions",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            widget.recipe.instructions ?? "",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Container(
                          color: Colors.grey.shade400,
                          height: 40,
                          width: 4,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            color: Colors.grey.shade400,
                            height: 40,
                            width: 4,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 24),
                    Text("Video",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    YoutubePlayer(
                      controller: _vidController,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List? _renderIngredientsList(recipe, context) {
  return recipe.ingredients
      ?.map(
        (ing) => ListTile(
          leading: ClipOval(
            child: CachedNetworkImage(
              width: 40,
              height: 40,
              imageUrl:
                  "https://themealdb.com/images/ingredients/${ing.ingredient}.png",
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
              message: ing.ingredient ?? "",
              child: Text(
                ing.ingredient ?? "",
                style: TextStyle(overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
            ),
          ),
          trailing: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 120),
            child: Tooltip(
              message: ing.measure ?? "",
              child: Text(
                ing.measure ?? "",
                textAlign: TextAlign.end,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ),
      )
      .toList();
}
