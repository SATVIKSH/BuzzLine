import 'package:news_app/res/app_colors.dart';
import 'package:news_app/view_models/all_news_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadScreen extends ConsumerWidget {
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(allNewsProvider.notifier).getAllNews(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.onBackgroundNoHighlight,
        ),
      ),
    );
  }
}
