import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splay/common/theme.dart';
import 'package:splay/presentation/controllers/main_controller.dart';

import '../../../widgets/audio_player_widget.dart';

class MainPageWeb extends StatelessWidget {
  const MainPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GetX<MainController>(
      builder: (controller) => Scaffold(
        backgroundColor: theme.primaryColor,
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraint) => SingleChildScrollView(
                  child: SizedBox(
                    width: 200,
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.0),
                            child: FlutterLogo(
                              size: 40,
                            ),
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          ...controller.navigationMenus.where((item) => item.isShowMenu).map(
                            (menu) {
                              bool isParent = controller
                                      .navigationMenus[controller.selectedNavigationMenu.value]
                                      .parent ==
                                  menu;
                              bool isSelectedMenu =
                                  controller.navigationMenus.indexWhere((item) => item == menu) ==
                                      controller.selectedNavigationMenu.value;

                              return InkWell(
                                onTap: () => controller.changeSelectedNavigationMenu(menu),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                                  padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 6.0,
                                    top: 6.0,
                                    bottom: 6.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isParent || isSelectedMenu
                                        ? theme.primaryColor
                                        : Colors.transparent,
                                    borderRadius: const BorderRadius.horizontal(
                                      right: Radius.circular(25.0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        menu.icon,
                                        color: isParent || isSelectedMenu ? colorWhite : colorGrey3,
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          menu.title,
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            color: isParent || isSelectedMenu
                                                ? colorWhite
                                                : colorGrey3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              VerticalDivider(
                color: theme.dividerColor,
              ),
              Expanded(
                child: controller.navigationMenus
                    .where((item) => item.isShowMenu)
                    .toList()[controller.selectedNavigationMenu.value]
                    .page,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          constraints: const BoxConstraints(maxHeight: 110),
          decoration: BoxDecoration(
            color: theme.primaryColor,
          ),
          child: const Center(
            child: AudioPlayerWidget(),
          ),
        ),
      ),
    );
  }
}
