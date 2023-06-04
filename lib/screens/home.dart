import 'dart:ui';

import 'package:advanced_bottom_sheet/widgets/custom_animated_switcher.dart';
import 'package:flutter/material.dart';

import '../controller/nature_controller.dart';
import '../models/nature_model.dart';
import '../widgets/custom_bottomsheet.dart';

final NatureController natureController = NatureController(
  natureModel: NatureModel.natureList[0],
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double width;
  late double height;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    natureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SizedBox(
        width: width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ListenableBuilder(
              listenable: natureController,
              builder: (context, child) {
                return Image.asset(
                  height: 10,
                  natureController.natureModel.image,
                  fit: BoxFit.cover,
                );
              },
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: const SizedBox.shrink(),
            ),
            ListenableBuilder(
              listenable: natureController,
              builder: (BuildContext context, Widget? child) {
                return Column(
                  children: [
                    SizedBox(height: height * 0.1),
                    Center(
                      child: CustomAnimatedSwitcher(
                        child: Container(
                          key: UniqueKey(),
                          width: width * 0.8,
                          height: height * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(2, 0),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage(
                                natureController.natureModel.image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Container(
                      width: width * 0.6,
                      height: height * 0.06,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        natureController.natureModel.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: width * 0.5,
                      height: height * 0.04,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        natureController.natureModel.artistName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const CustomBottomSheet(),
          ],
        ),
      ),
    );
  }
}
