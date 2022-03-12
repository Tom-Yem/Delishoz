import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Details/widgets/widgets.dart';

// recipe model
import 'package:recipe_app/Search/Model/recipeModel.dart';
import 'package:skeletons/skeletons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
                    child: CachedNetworkImage(
                      imageUrl: widget.recipe.image!,
                      fit: BoxFit.cover,
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      placeholder: (context, _) => SkeletonAvatar(),
                    ),
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
            IngredientDetail(
                recipe: widget.recipe, vidController: _vidController)
          ],
        ),
      ),
    );
  }
}
