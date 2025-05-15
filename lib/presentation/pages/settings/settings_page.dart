import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/settings_controller.dart';
import 'responsive/settings_page_web.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<SettingsController>(
      init: SettingsController(),
      didChangeDependencies:
          (state) => WidgetsBinding.instance.addPostFrameCallback(
            (_) => state.controller?.getDirectorySaved(),
          ),
      builder: (_) {
        if (size.width <= 700) {
          return const SettingsPageWeb();
        }
        return const SettingsPageWeb();
      },
    );
  }
}
