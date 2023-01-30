import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    super.key,
    required this.lottiePath,
    this.isReplay,
    this.horizontalSpacing,
    this.verticalSpacing,
    this.child,
  });

  final String lottiePath;
  final bool? isReplay;
  final double? horizontalSpacing;
  final double? verticalSpacing;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height / 3,
            child: LottieBuilder.asset(
              lottiePath,
              repeat: isReplay ?? false,
            ),
          ),
          SizedBox(
            height: verticalSpacing ?? 8.0,
          ),
          if (child != null)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalSpacing ?? 32.0,
              ),
              child: child!,
            ),
        ],
      ),
    );
  }
}
