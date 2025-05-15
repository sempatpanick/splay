import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splay/presentation/pages/library/responsive/library_page_phone.dart';
import 'package:splay/presentation/pages/library/responsive/library_page_web.dart';

import '../../controllers/library_controller.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<LibraryController>(
      init: LibraryController(),
      didChangeDependencies:
          (state) => WidgetsBinding.instance.addPostFrameCallback(
            (_) => state.controller?.initialize(),
          ),
      builder: (_) {
        if (size.width <= 700) {
          return const LibraryPagePhone();
        }
        return const LibraryPageWeb();
      },
    );
  }
}
