import 'package:flutter/material.dart';
import 'package:splay/presentation/pages/main/responsive/main_page_phone.dart';
import 'package:splay/presentation/pages/main/responsive/main_page_web.dart';

class MainPage extends StatelessWidget {
  static const String routeName = '/main';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (size.width <= 700) {
      return MainPagePhone();
    }
    return MainPageWeb();
  }
}
