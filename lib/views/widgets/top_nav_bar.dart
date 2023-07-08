import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/response/status.dart';
import 'package:news_app/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:news_app/res/text_styles.dart';
import 'package:news_app/view_models/all_news_provider.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const List categories = [
  'General',
  'Business',
  'Entertainment',
  'Health',
  'Science',
  'Sports',
  'Technology'
];

class TopNavBar extends ConsumerStatefulWidget {
  const TopNavBar({super.key, required this.country});
  final String country;
  @override
  ConsumerState<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends ConsumerState<TopNavBar> {
  var selectedIndex = 0;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _itemScrollController = ItemScrollController();
    final apiResponse = ref.watch(allNewsProvider);

    return SizedBox(
      height: 28,
      child: ScrollablePositionedList.builder(
        itemScrollController: _itemScrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              apiResponse.status == Status.LOADING
                  ? () {}
                  : setState(() {
                      selectedIndex = index;

                      _itemScrollController.jumpTo(
                          index: index, alignment: index * (1 / 10));
                      ref.read(allNewsProvider.notifier).getCategoryNews(
                          category: categories[index].toString().toLowerCase(),
                          context: context,
                          country: widget.country);
                    });
            },
            child: Padding(
              padding: EdgeInsets.only(
                  right: 16, top: index == selectedIndex ? 0 : 6),
              child: Text(
                categories[index],
                style: TextStyles.title.copyWith(
                    color: index == selectedIndex
                        ? AppColors.onBackgroundHighlight
                        : AppColors.onBackgroundNoHighlight,
                    fontSize: index == selectedIndex ? 20 : null),
              ),
            ),
          );
        },
        itemCount: categories.length,
      ),
    );
  }
}
