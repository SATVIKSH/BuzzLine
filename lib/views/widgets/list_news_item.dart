import 'package:flutter/material.dart';

import 'package:news_app/models/news_model.dart';
import 'package:news_app/res/app_colors.dart';
import 'package:news_app/res/text_styles.dart';
import 'package:news_app/utils/routes_name.dart';

class ListNewsItem extends StatelessWidget {
  const ListNewsItem({super.key, required this.news});
  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    ImageProvider getImage(String? url) {
      if (url != null) {
        return NetworkImage(
          url,
        );
      } else {
        return const AssetImage('assets/images/newsbg.jpeg');
      }
    }

    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RoutesName.newsDetail, arguments: news);
      },
      child: SizedBox(
        width: screenSize.width * 0.92,
        height: 80,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 8, horizontal: screenSize.width * 0.05),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenSize.width * 0.27,
                height: 60,
                child: FadeInImage(
                  image: getImage(news.image),
                  placeholder: const AssetImage('assets/images/newsbg.jpeg'),
                  fadeInCurve: Curves.linear,
                  fadeOutCurve: Curves.linear,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.6,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        news.title!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.cardDescription.copyWith(
                            color: AppColors.onBackgroundHighlight,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
