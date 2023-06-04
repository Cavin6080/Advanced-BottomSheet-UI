import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/nature_model.dart';
import 'image_widget.dart';
import 'title_bar.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  double get maxHeight => MediaQuery.of(context).size.height - 150;

  final double imgStartSize = 45;
  final double imgEndSize = 120;
  final double imgVerticleSpace = 25;
  final double imgHorizontalSpace = 15;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          // at the start,the height will be 120 becuase the
          // animationcontroller's value is zero
          height: lerp(
            min: 120,
            max: maxHeight,
            factor: _animationController.value,
          ),
          child: GestureDetector(
            onTap: toggle,
            onVerticalDragUpdate: _onVerticleDragUpdate,
            onVerticalDragEnd: _onVerticleDragEnd,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.grey.shade300,
                    offset: const Offset(2, 0),
                  ),
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 2,
                    color: Colors.grey.shade300,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  // title bar widget
                  Positioned(
                    left: 0,
                    right: 0,
                    top: lerp(
                      min: 15,
                      max: 20,
                      factor: _animationController.value,
                    ),
                    child: TitleBar(
                      animationStatus: _animationController.status,
                      factor: _animationController.value,
                    ),
                  ),
                  // scrollable photo widget
                  Positioned(
                    top: lerp(
                      min: 35,
                      max: 70,
                      factor: _animationController.value,
                    ),
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ListView(
                      scrollDirection: _animationController.status ==
                              AnimationStatus.completed
                          ? Axis.vertical
                          : Axis.horizontal,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      cacheExtent: 20,
                      children: [
                        SizedBox(
                          height: (imgEndSize + imgVerticleSpace) *
                              NatureModel.natureList.length,
                          width: (imgStartSize + imgHorizontalSpace) *
                              NatureModel.natureList.length,
                          child: Stack(
                            children: [
                              for (int i = 0;
                                  i < NatureModel.natureList.length;
                                  i++)
                                CustomImageWidget(
                                  natureModel: NatureModel.natureList[i],
                                  imgSize: lerp(
                                    min: imgStartSize,
                                    max: imgEndSize,
                                    factor: _animationController.value,
                                  )!,
                                  topMargin: imgTopMargin(i) ?? 0,
                                  leftMargin: imgLeftMargin(i) ?? 0,
                                  isCompleted: _animationController.status ==
                                      AnimationStatus.completed,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double? imgTopMargin(int index) {
    return lerp(
      min: 20,
      max: 10 + index * (imgVerticleSpace + imgEndSize),
      factor: _animationController.value,
    );
  }

  double? imgLeftMargin(int index) {
    return lerp(
      min: index * (imgHorizontalSpace + imgStartSize),
      max: 0,
      factor: _animationController.value,
    );
  }

  /// open and close the bottomsheet
  void toggle() {
    final bool isCompleted =
        _animationController.status == AnimationStatus.completed;
    _animationController.fling(velocity: isCompleted ? -1 : 1);
  }

  void _onVerticleDragUpdate(DragUpdateDetails details) {
    /// when swiping up [details.primaryDelta] will be negative
    /// that will cause the animationcontroller value increase
    /// when swiping down [details.primaryDelta] will be positive
    /// [details.primaryDelta! / maxHeight] are between 0 and 1
    _animationController.value -= details.primaryDelta! / maxHeight;

    /// [primary delta] is nothing but delta in specific direction
    /// [delta] will give you drag update in both X and Y coordinates
  }

  void _onVerticleDragEnd(DragEndDetails details) {
    if (_animationController.isAnimating ||
        _animationController.status == AnimationStatus.completed) {
      return;
    }

    // [flingVelocity] is decreasing when we scroll up and increasing
    // when we swipe down
    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;

    // [flingVelocity < 0] means we're swiping up then open it completly
    // here we're checking how fast the velocity should be based on
    // the users interaction
    if (flingVelocity < 0) {
      _animationController.fling(velocity: max(1, -flingVelocity));
    } else if (flingVelocity > 0) {
      _animationController.fling(velocity: min(1, -flingVelocity));
    } else {
      _animationController.fling(
        velocity: _animationController.value < 0.5 ? -1 : 1,
      );
    }
  }
}

/// lerpDouble: Linearly interpolate between two numbers
/// a + (b - a) * t
/// 120 + (500 - 120) * 1
double? lerp(
    {required double min, required double max, required double factor}) {
  return lerpDouble(
    min,
    max,
    factor,
    // _animationController.value,
  );
}
