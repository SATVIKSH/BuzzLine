import 'package:news_app/data/response/status.dart';
import 'package:news_app/res/app_colors.dart';
import 'package:news_app/res/text_styles.dart';

import 'package:news_app/view_models/all_news_provider.dart';

import 'package:news_app/views/widgets/list_news_item.dart';

import 'package:news_app/views/widgets/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Widget? widget;
    final allNewsResponse = ref.watch(allNewsProvider);
    if (allNewsResponse.status == Status.LOADING) {
      widget = Center(
        child: CircularProgressIndicator(
          color: AppColors.onBackgroundNoHighlight,
        ),
      );
    }
    if (allNewsResponse.status == Status.ERROR) {
      widget = Center(
        child: Text(
          allNewsResponse.message!,
          style: TextStyles.content
              .copyWith(color: AppColors.onBackgroundNoHighlight),
        ),
      );
    }
    if (allNewsResponse.status == Status.COMPLETED) {
      final allNews = allNewsResponse.data!;
      widget = Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.3,
                right: screenSize.width * 0.3,
                bottom: screenSize.height * 0.01),
            child: Divider(
              height: screenSize.height * 0.01,
              thickness: screenSize.width * 0.004,
              color: AppColors.onBackgroundNoHighlight,
            ),
          ),
          // Padding(
          //     padding: EdgeInsets.symmetric(
          //         vertical: screenSize.height * 0.01,
          //         horizontal: screenSize.width * 0.04),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.max,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Text(
          //           'Top Articles',
          //           textAlign: TextAlign.left,
          //           style: TextStyles.secondaryTitle
          //               .copyWith(color: Colors.white),
          //         ),
          //       ],
          //     )),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //       vertical: screenSize.height * 0.01,
          //       horizontal: screenSize.width * 0.01),
          //   child: NewsCard(
          //     newsList: allNews,
          //   ),
          // ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return ListNewsItem(news: allNews[index]);
            },
            itemCount: allNews.length,
          ))
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.background,
            title: Text(
              'News',
              style: TextStyles.mainTitle
                  .copyWith(color: AppColors.onBackgroundHighlight),
            ),
          ),
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.02,
                    horizontal: screenSize.width * 0.04),
                child: const TopNavBar(),
              ),
              Expanded(child: widget!),
            ],
          )),
    );
  }
}
