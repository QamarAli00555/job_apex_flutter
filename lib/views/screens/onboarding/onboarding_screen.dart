import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_apex/controllers/onboarding_provider.dart';
import 'package:job_apex/views/common/exports.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widget/PageOne.dart';
import 'widget/PageThree.dart';
import 'widget/PageTwo.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<OnBoardNotifier>(builder: (context, onBoardNotifier, child) {
      return Stack(
        children: [
          PageView(
            controller: pageController,
            physics: onBoardNotifier.isLastPage
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            children: const [PageOne(), PageTwo(), PageThree()],
            onPageChanged: (page) {
              onBoardNotifier.isLastPage = page == 2;
            },
          ),
          onBoardNotifier.isLastPage
              ? const SizedBox.shrink()
              : Positioned(
                  bottom: hieght * 0.07,
                  left: 0,
                  right: 0,
                  child: Center(
                      child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: WormEffect(
                        dotColor: Color(kLight.value),
                        activeDotColor: Color(kOrange.value),
                        dotHeight: 12,
                        dotWidth: 12,
                        spacing: 10),
                  ))),
          onBoardNotifier.isLastPage
              ? const SizedBox.shrink()
              : Positioned(
                  child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              pageController.jumpTo(2);
                            },
                            child: ReusableText(
                                text: 'Skip',
                                style: appStyle(16, Color(kLight.value),
                                    FontWeight.normal)),
                          ),
                          InkWell(
                            onTap: () {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            },
                            child: ReusableText(
                                text: 'Next',
                                style: appStyle(16, Color(kLight.value),
                                    FontWeight.normal)),
                          )
                        ]),
                  ),
                ))
        ],
      );
    }));
  }
}
