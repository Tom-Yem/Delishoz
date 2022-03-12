import 'package:flutter/material.dart';
import 'package:recipe_app/Search/Model/stateView.dart';
import 'package:skeletons/skeletons.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
    required this.status,
    required this.savedRecipes,
  }) : super(key: key);

  final StateView status;
  final List savedRecipes;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
    );
  }
}
