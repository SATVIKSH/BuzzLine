import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/res/app_colors.dart';
import 'package:news_app/res/text_styles.dart';
import 'package:news_app/utils/routes_name.dart';

import 'package:swipable_stack/swipable_stack.dart';
import 'package:intl/intl.dart';

class NewsCard extends ConsumerStatefulWidget {
  const NewsCard({super.key, required this.newsList});
  final List<NewsModel> newsList;
  @override
  ConsumerState<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends ConsumerState<NewsCard> {
  ImageProvider getImage(String? url) {
    if (url != null) {
      return NetworkImage(url);
    } else {
      return const AssetImage('assets/images/newsbg.jpeg');
    }
  }

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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                Positioned.fill(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RoutesName.newsDetail,
                          arguments: newsList[index + 1]);
                    },
                    child: FadeInImage(
                        fadeInCurve: Curves.linear,
                        fadeOutCurve: Curves.linear,
                        fit: BoxFit.cover,
                        placeholder:
                            const AssetImage('assets/images/newsbg.jpeg'),
                        image: getImage(newsList[index].image)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.black12],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 4, right: 8, left: 8, bottom: 16),
                      child: Column(
                        children: [
                          Text(
                            newsList[index].title!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.cardTitle.copyWith(
                                color: AppColors.onBackgroundHighlight),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Text(
                                newsList[index].author != null
                                    ? newsList[index].author!
                                    : 'Anonymous',
                                style: TextStyles.cardDescription.copyWith(
                                    color:
                                        AppColors.onCardBackgroundNoHighlight),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 3,
                                backgroundColor:
                                    AppColors.onCardBackgroundNoHighlight,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                newsList[index].publishDate != null
                                    ? DateFormat.yMMMEd()
                                        .format(newsList[index].publishDate!)
                                    : "",
                                style: TextStyles.cardDescription.copyWith(
                                    color:
                                        AppColors.onCardBackgroundNoHighlight),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
