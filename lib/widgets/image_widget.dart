import 'package:flutter/material.dart';

import '../models/nature_model.dart';
import '../screens/home.dart';

class CustomImageWidget extends StatelessWidget {
  final NatureModel natureModel;
  final double imgSize;
  final double topMargin;
  final double leftMargin;
  final bool isCompleted;
  const CustomImageWidget({
    super.key,
    required this.natureModel,
    required this.imgSize,
    required this.leftMargin,
    required this.isCompleted,
    required this.topMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      child: GestureDetector(
        onTap: () => natureController.natureModel = natureModel,
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin:
              isCompleted ? const EdgeInsets.symmetric(horizontal: 10) : null,
          decoration: isCompleted
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 2,
                      color: Colors.grey.shade400,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                )
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: imgSize,
                width: imgSize,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  natureModel.image,
                  fit: BoxFit.cover,
                ),
              ),
              Visibility(
                visible: isCompleted,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          natureModel.title,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          natureModel.artistName,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
