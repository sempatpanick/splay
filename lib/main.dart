import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splay/common/theme.dart';
import 'package:splay/presentation/pages/main/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      initialRoute: MainPage.routeName,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('id', 'ID'),
      ],
      getPages: [
        GetPage(
          name: MainPage.routeName,
          page: () => const MainPage(),
        ),
      ],
    );
  }
}
