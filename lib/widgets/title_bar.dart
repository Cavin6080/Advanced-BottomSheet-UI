import 'package:flutter/material.dart';

import 'custom_bottomsheet.dart';

class TitleBar extends StatelessWidget {
  final double factor;
  final AnimationStatus animationStatus;
  const TitleBar({
    super.key,
    required this.factor,
    required this.animationStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Popular Nature Photos',
          style: TextStyle(
            color: Colors.black87,
            fontSize: lerp(
              min: 21,
              max: 23,
              factor: factor,
            ),
            fontWeight: FontWeight.w500,
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          switchInCurve: Curves.easeOutExpo,
          switchOutCurve: Curves.easeOutExpo,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation.drive(
                Tween(
                  begin: 0.3,
                  end: 1,
                ),
              ),
              child: child,
            );
          },
          child: Icon(
            key: UniqueKey(),
            animationStatus == AnimationStatus.completed
                ? Icons.arrow_downward
                : Icons.arrow_upward,
            color: Colors.black87,
            size: lerp(
              min: 25,
              max: 28,
              factor: factor,
            ),
          ),
        )
      ],
    );
  }
}
