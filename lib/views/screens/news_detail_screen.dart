import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/res/app_colors.dart';
import 'package:news_app/res/text_styles.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key, required this.news});
  final NewsModel news;
  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  ImageProvider getImage(String? url) {
    if (url != null) {
      return NetworkImage(
        url,
      );
    } else {
      return const AssetImage('assets/images/newsbg.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final news = widget.news;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: screenSize.width,
              height: screenSize.height * 0.3,
              child: FadeInImage(
                image: getImage(news.image),
                placeholder: const AssetImage('assets/images/newsbg.jpeg'),
                fadeInCurve: Curves.linear,
                fadeOutCurve: Curves.linear,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.01,
                  horizontal: screenSize.width * 0.04),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    news.title!,
                    style: TextStyles.secondaryTitle
                        .copyWith(color: AppColors.onBackgroundHighlight),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          news.author != null
                              ? '${news.author!} | '
                              : 'Anonymous',
                          style: TextStyles.content.copyWith(
                              color: AppColors.onBackgroundHighlight,
                              fontSize: 14),
                        ),
                        Text(
                          news.publishDate != null
                              ? DateFormat.yMMMEd().format(news.publishDate!)
                              : "",
                          style: TextStyles.content.copyWith(
                              color: AppColors.onBackgroundHighlight,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenSize.width * 0.03,
                        right: screenSize.width * 0.03,
                        top: screenSize.height * 0.01),
                    child: Divider(
                      height: screenSize.height * 0.01,
                      thickness: screenSize.width * 0.004,
                      color: AppColors.onBackgroundNoHighlight,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.height * 0.01,
                      left: screenSize.width * 0.03,
                      right: screenSize.width * 0.03,
                    ),
                    child: Text(
                      news.description != null
                          ? "\"${news.description!}\""
                          : "",
                      textAlign: TextAlign.center,
                      style: TextStyles.content.copyWith(
                          color: AppColors.onBackgroundHighlight, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
