import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  const CustomAnimatedSwitcher({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      switchInCurve: Curves.easeOutExpo,
      switchOutCurve: Curves.easeOutExpo,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation.drive(
            Tween(
              begin: 0.3,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}
