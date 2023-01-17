import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/curve_box.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ['Reminders', 'To-do List', 'Audio', 'Image'];

    return Scaffold(
      body: AnimationLimiter(
        child: MasonryGridView.count(
          padding: const EdgeInsets.all(16.0),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
            position: 1,
            duration: const Duration(milliseconds: 500),
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                curve: Curves.easeInCubic,
                child: CurvedBox(
                  children: [
                    LottieBuilder.asset(
                      'assets/animations/folders.json',
                      repeat: false,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          categories[index],
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          itemCount: categories.length,
        ),
      ),
    );
  }
}
