import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koreanapp/resources/colorManager.dart';

import '../../utils/screenconfig.dart';
import '../onboarding_contents.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  List colors = [
    // const Color.fromARGB(249, 237, 237, 1),
    ColorManager.primary,
    const Color.fromARGB(255, 128, 177, 206),

    // const Color.fromARGB(255, 214, 159, 143),
    const Color.fromARGB(255, 150, 216, 137)
  ];

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF000000),
        // color: Colors.red),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    // double blockH = SizeConfig.blockH!;
    // double blockV = SizeConfig.blockV!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
          child: Stack(
        children: [
          CustomPaint(
            painter:
                VennDiagramPainter(), // CustomPainter to draw Venn diagram-like shapes
            child: Container(),
          ),
          Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  itemCount: contents.length,
                  itemBuilder: (context, i) {
                    return Container(
                      // color: colors[i],
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            Image.asset(
                              contents[i].image,
                              height: SizeConfig.blockV! * 35,
                            ),
                            SizedBox(
                              height: (height >= 840) ? 60 : 30,
                            ),
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: (width <= 550) ? 30 : 35,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              contents[i].desc,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: (width <= 550) ? 20 : 26,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length,
                        (int index) => _buildDots(index: index),
                      ),
                    ),
                    _currentPage + 1 == contents.length
                        ? Padding(
                            padding: const EdgeInsets.all(30),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Text("Hello");
                                  // return const RegisterPage();
                                }));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: (width <= 550)
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 20)
                                    : EdgeInsets.symmetric(
                                        horizontal: width * 0.2, vertical: 25),
                                textStyle: TextStyle(
                                    fontSize: (width <= 550) ? 13 : 17),
                              ),
                              child: const Text("GET STARTED",
                                  style: TextStyle(
                                      fontSize: 15, letterSpacing: 1.5)),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _controller.jumpToPage(2);
                                  },
                                  style: TextButton.styleFrom(
                                    elevation: 0,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: (width <= 550) ? 13 : 17,
                                    ),
                                  ),
                                  child: const Text(
                                    "SKIP",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    elevation: 0,
                                    padding: (width <= 550)
                                        ? const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20)
                                        : const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 25),
                                    textStyle: TextStyle(
                                        fontSize: (width <= 550) ? 13 : 17),
                                  ),
                                  child: const Text(
                                    "NEXT",
                                    style: TextStyle(
                                        fontSize: 15, letterSpacing: 1.5),
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

// circle of onboarding screen, all screen

class VennDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final overlapPaint = Paint()
      ..color = ColorManager.onboardingCircleoverlap
      ..style = PaintingStyle.fill;

    final bluePaint = Paint()
      ..color =
          ColorManager.onboardingCircle // Color for the non-intersection areas
      ..style = PaintingStyle.fill;

    // Calculate the radius based on the size of the canvas
    final radius = size.width * 0.2;

    // Calculate the position for the circles to overlap at the top-left corner
    final circle1Center = Offset(size.width * 0.00001, size.height * 0.06);
    final circle2Center = Offset(size.width * 0.19, size.height * 0.00001);

    // Calculate the path for the intersection area
    final intersectionPath = Path()
      ..addArc(
          Rect.fromCircle(center: circle1Center, radius: radius), 0, 2 * 3.14)
      ..addArc(
          Rect.fromCircle(center: circle2Center, radius: radius), 0, 2 * 3.14);

    // Create a clipping path to display only half of the intersection
    final clipPath = Path()
      ..addRect(Rect.fromPoints(
          const Offset(0, 0), Offset(size.width * 0.2, size.height)))
      ..addPath(intersectionPath, const Offset(0, 0));

    // Clip the canvas with the clipping path
    canvas.clipPath(clipPath);

    // Translate the diagram to the top-left corner
    canvas.translate(0, 0);

    // Draw the intersection area with red
    canvas.drawPath(intersectionPath, overlapPaint);

    // Calculate the path for the non-intersection areas
    final nonIntersectionPath = Path()
      ..addArc(
          Rect.fromCircle(center: circle1Center, radius: radius), 0, 2 * 3.14)
      ..addArc(
          Rect.fromCircle(center: circle2Center, radius: radius), 0, 2 * 3.14)
      ..fillType = PathFillType.evenOdd; // Exclude the intersection

    // Draw the non-intersection areas with blue
    canvas.drawPath(nonIntersectionPath, bluePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
