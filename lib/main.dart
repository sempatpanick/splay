import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splay/common/theme.dart';
import 'package:splay/presentation/pages/main/main_page.dart';
import 'package:window_size/window_size.dart';

import 'injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('SPlay - Music Player');
    setWindowMinSize(const Size(400, 500));
  }
  init();
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
      supportedLocales: const [Locale('en', 'US'), Locale('id', 'ID')],
      getPages: [
        GetPage(name: MainPage.routeName, page: () => const MainPage()),
      ],
    );
  }
}
