import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/news_model.dart';

import 'package:news_app/views/widgets/news_card_stack.dart';

import 'package:swipable_stack/swipable_stack.dart';

class NewsCard extends ConsumerStatefulWidget {
  const NewsCard({super.key, required this.newsList});
  final List<NewsModel> newsList;
  @override
  ConsumerState<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends ConsumerState<NewsCard> {
  @override
  void initState() {
    super.initState();
  }

  var index = 0;
  @override
  Widget build(
    BuildContext context,
  ) {
    final screenSize = MediaQuery.of(context).size;
    List<NewsModel> newsList = [];

    for (int i = 0; i < 5; i++) {
      newsList.add(widget.newsList[i]);
    }

    return SizedBox(
      height: screenSize.height * 0.3,
      width: screenSize.width * 0.94,
      child: SwipableStack(
        detectableSwipeDirections: const {
          SwipeDirection.right,
          SwipeDirection.left,
          SwipeDirection.up,
          SwipeDirection.down
        },
        builder: ((context, swipeProperty) {
          index = swipeProperty.index % (newsList.length - 1);
          print(swipeProperty.index);
          return Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: NewsCardStack(
                newsArticle: newsList[index],
              ));
        }),
      ),
    );
  }
}
