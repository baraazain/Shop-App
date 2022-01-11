import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/network/local/shared_preferance.dart';
import 'package:shop_app/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Data {
  String image, title, content;
  Data(this.image, this.title, this.content);
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Data> list = [
    Data('assets/images/boarding1.webp',
        'cheap',
        'we have clothes very cheap and very modern to be very genteel'),
    Data('assets/images/boarding3.jpg',
        'very good',
        'we have clothes very cheap and very modern to be very genteel'),
    Data('assets/images/boarding5.webp',
        'all size',
        'we have clothes very cheap and very modern to be very genteel'),
  ];

  var onboardingControler = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.saveData(key: 'onBoarding', value:true);
                goToFinal(context,  LoginScreen());
              },
              child: const Text('Skip')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => pageItem(list[index]),
                itemCount: list.length,
                onPageChanged: (index) {
                  if (index == list.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: onboardingControler,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onboardingControler,
                  count: list.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 10),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.saveData(key: 'onBoarding', value:true);
                      goToFinal(context, LoginScreen());
                    } else {
                      onboardingControler.nextPage(
                        duration: const Duration(
                          milliseconds: 1000,
                        ),
                        curve: Curves.easeInOutCirc,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget pageItem(object) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage('${object.image}'),
              ),
            ),
          ),
          Text(
            '${object.title}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '${object.content}',
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                fontSize: 16),
          ),
        ],
      );
}
