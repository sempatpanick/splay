import 'package:get/get.dart';

import '../../common/enum.dart';

class MainController extends GetxController {
  RxList<NavigationMenuData> navigationMenus = NavigationMenuData.values.obs;
  RxInt selectedNavigationMenu = 0.obs;

  void changeSelectedNavigationMenu(NavigationMenuData menu) {
    final searchMenuIndex = navigationMenus.indexWhere((item) => item == menu);
    if (selectedNavigationMenu.value == searchMenuIndex) return;
    selectedNavigationMenu.value = searchMenuIndex;
  }
}
