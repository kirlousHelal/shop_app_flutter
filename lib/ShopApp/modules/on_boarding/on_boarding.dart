import 'package:flutter/material.dart';
import 'package:shop_app_myself/ShopApp/models/page_model.dart';
import 'package:shop_app_myself/ShopApp/modules/login/login_screen.dart';
import 'package:shop_app_myself/ShopApp/shared/components/components.dart';
import 'package:shop_app_myself/ShopApp/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/network/local/cache_helper.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});

  var pageController = PageController();
  List<PageModel> pages = [
    PageModel(
        image:
            "https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg",
        head: "Head 1",
        body: "Body 1"),
    PageModel(
        image:
            "https://img.freepik.com/free-photo/abstract-autumn-beauty-multi-colored-leaf-vein-pattern-generated-by-ai_188544-9871.jpg",
        head: "Head 2",
        body: "Body 2"),
    PageModel(
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiI76D9VIJtd-mUicPtv07vgr1ZcKobACqyg&s",
        head: "Head 3",
        body: "Body 3"),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("On Boarding"),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
            child: TextButton(
              onPressed: () {
                CacheHelper.saveData(key: "onBoard", value: true);
                navigateTo(context: context, screen: LoginScreen());
              },
              child: const Text(
                "SKIP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                if (value == pages.length - 1) {
                  isLast = true;
                } else {
                  isLast = false;
                }
              },
              controller: pageController,
              itemBuilder: (context, index) {
                return pageBuilder(pages[index]);
              },
              physics: const BouncingScrollPhysics(),
              itemCount: pages.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  effect: SwapEffect(
                    activeDotColor: defaultColor as Color,
                    dotColor: Colors.grey,
                    type: SwapType.yRotation,
                    paintStyle: PaintingStyle.stroke,
                  ),
                  controller: pageController,
                  count: pages.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.saveData(key: "onBoard", value: true);
                      navigateTo(
                          context: context,
                          screen: LoginScreen(),
                          goBack: false);
                      return;
                    }
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear,
                    );
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget pageBuilder(PageModel page) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(page.image),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 350,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  page.head,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Text(
                  page.body,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      );
}
