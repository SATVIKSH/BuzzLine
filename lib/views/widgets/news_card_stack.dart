import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_model.dart';

import '../../res/app_colors.dart';
import '../../res/text_styles.dart';
import '../../utils/routes_name.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsCardStack extends StatelessWidget {
  const NewsCardStack({super.key, required this.newsArticle});
  final NewsModel newsArticle;
  Widget getImage(String? url) {
    if (url != null && url.trim() != "") {
      return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => Image.asset(
          'assets/images/newsbg.jpeg',
          fit: BoxFit.cover,
        ),
        errorWidget: (context, irl, error) {
          print(error.toString());
          return Image.asset(
            'assets/images/newsbg.jpeg',
            fit: BoxFit.cover,
          );
        },
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/newsbg.jpeg',
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: screenSize.height * 0.02,
            left: screenSize.width * 0.04,
            right: screenSize.width * 0.04),
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(RoutesName.newsDetail, arguments: newsArticle);
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            height: screenSize.height * 0.27,
            width: screenSize.width * 0.9,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                Positioned.fill(child: getImage(newsArticle.image)),
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
                            newsArticle.title!,
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
                                newsArticle.author != null
                                    ? newsArticle.author!
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
                                newsArticle.publishDate != null
                                    ? DateFormat.yMMMEd()
                                        .format(newsArticle.publishDate!)
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
          ),
        ),
      ),
    );
  }
}
