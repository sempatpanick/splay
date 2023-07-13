import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/main_controller.dart';
import '../../../widgets/audio_player_widget.dart';

class MainPagePhone extends StatelessWidget {
  const MainPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GetX<MainController>(
      init: MainController(),
      builder: (controller) => Scaffold(
        body: controller.navigationMenus
            .where((item) => item.isShowMenu && item.parent == null)
            .toList()[controller.selectedNavigationMenu.value]
            .page,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.selectedPlayingMusicMetadata.value != null) const AudioPlayerWidget(),
            BottomNavigationBar(
              backgroundColor: theme.primaryColor,
              currentIndex: controller.selectedNavigationMenu.value,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white60,
              items: controller.navigationMenus
                  .where((item) => item.isShowMenu && item.parent == null)
                  .map(
                    (item) => BottomNavigationBarItem(
                      icon: Icon(item.icon),
                      label: item.title,
                    ),
                  )
                  .toList(),
              onTap: (value) => controller.changeSelectedNavigationMenu(
                controller.navigationMenus
                    .where((item) => item.isShowMenu && item.parent == null)
                    .toList()[value],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
