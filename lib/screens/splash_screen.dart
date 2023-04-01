import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:untitled1/screens/auth/login.dart';
import 'package:untitled1/screens/theme_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemedDarkBg,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwiperIndicatorItem(
                    active: currentSlide == 0,
                  ),
                  SwiperIndicatorItem(
                    active: currentSlide == 1,
                  ),
                  SwiperIndicatorItem(
                    active: currentSlide == 2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Swiper(
                onIndexChanged: (index) {
                  setState(() {
                    currentSlide = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return const SplashSlideItem(
                        icon: Icons.four_g_mobiledata_outlined,
                      );
                    case 1:
                      return const SplashSlideItem(
                        title: "Woks Offline",
                        icon: Icons.signal_wifi_connected_no_internet_4_rounded,
                        color: Colors.teal,
                        description:
                            "You can make data purchase offline without having "
                            "internet access, this allows you to buy data plans even when your "
                            "out of data to access the internet ",
                      );
                    default:
                      return const SplashSlideItem(
                        title: "Earn Bonus",
                        icon: Icons.people_outline_rounded,
                        description:
                            "Refer others to purchase their data plans from "
                            "our services, and get rewards for each data plan of above 2GB ",
                      );
                  }
                },
                itemCount: 3,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (content) => const LoginScreen()));
                },
                style: FilledButton.styleFrom(backgroundColor: ThemedColorDark),
                child: Text("get start".toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SwiperIndicatorItem extends StatelessWidget {
  const SwiperIndicatorItem({Key? key, this.active = false}) : super(key: key);
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: active ? 8 : 4,
      width: 26,
      decoration: BoxDecoration(
          color: active ? ThemedColor : Colors.white24,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
    );
  }
}

class SplashSlideItem extends StatelessWidget {
  const SplashSlideItem(
      {Key? key,
      this.title,
      this.description,
      this.cover,
      this.color = ThemedColor,
      this.icon = Icons.network_check_rounded})
      : super(key: key);

  final String? title, description;
  final Image? cover;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: const Offset(-10, 50),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              icon,
              color: color.withOpacity(0.15),
              size: 186,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (title != null ? title! : "Purchase Data").toUpperCase(),
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                description != null
                    ? description!
                    : "Sometimes you may also want to change"
                        " the text color of the Elevated Button."
                        " You can do that by just assigning the"
                        " color of your choice to onPrimary property.",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                    color: Colors.white60),
              )
            ],
          ),
        ),
      ],
    );
  }
}
