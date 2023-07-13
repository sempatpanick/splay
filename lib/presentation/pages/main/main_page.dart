import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splay/presentation/pages/main/responsive/main_page_phone.dart';
import 'package:splay/presentation/pages/main/responsive/main_page_web.dart';

import '../../controllers/main_controller.dart';

class MainPage extends StatelessWidget {
  static const String routeName = '/main';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<MainController>(
      init: MainController(),
      builder: (_) {
        if (size.width <= 700) {
          return const MainPagePhone();
        }
        return const MainPageWeb();
      },
    );
  }
}
