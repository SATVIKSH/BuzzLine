import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/res/app_colors.dart';
import 'package:news_app/res/country_list.dart';
import 'package:news_app/res/current_country.dart';
import 'package:news_app/res/text_styles.dart';
import 'package:news_app/view_models/all_news_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CountryListView extends ConsumerStatefulWidget {
  CountryListView({super.key});

  @override
  ConsumerState<CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends ConsumerState<CountryListView> {
  final countryList = CountryList.countryList;
  var selectedIndex;
  @override
  Widget build(
    BuildContext context,
  ) {
    final scrollController = ItemScrollController();
    final screenSize = MediaQuery.of(context).size;
    for (int i = 0; i < countryList.length; i++) {
      if (countryList[i].code == CurrentCountry.currentCountry) {
        selectedIndex = i;
      }
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.06,
            horizontal: screenSize.width * 0.02),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: AppColors.onBackgroundHighlight,
                ),
                SizedBox(
                  width: screenSize.width * 0.08,
                ),
                Text(
                  "Choose a country",
                  style: TextStyles.mainTitle
                      .copyWith(color: AppColors.onBackgroundHighlight),
                ),
              ],
            ),
            Expanded(
              child: ScrollablePositionedList.builder(
                initialAlignment: 0.2,
                initialScrollIndex: selectedIndex,
                itemScrollController: scrollController,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        ref.read(allNewsProvider.notifier).getCategoryNews(
                            category: "general",
                            context: context,
                            country: countryList[index].code);

                        CurrentCountry.setCountry(countryList[index].code);
                        Navigator.of(context).pop();
                      });
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.6,
                          height: screenSize.height * 0.15,
                          child: Image.asset(
                            countryList[index].asset,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Text(
                          countryList[index].name,
                          style: TextStyles.cardTitle.copyWith(
                              color: CurrentCountry.currentCountry ==
                                      countryList[index].code
                                  ? AppColors.onBackgroundHighlight
                                  : AppColors.onBackgroundNoHighlight,
                              fontSize: 22),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.07,
                        )
                      ],
                    ),
                  );
                },
                itemCount: countryList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
