import 'package:flutter/material.dart';
import 'package:splay/presentation/pages/library/responsive/library_page_phone.dart';
import 'package:splay/presentation/pages/library/responsive/library_page_web.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (size.width <= 700) {
      return LibraryPagePhone();
    }
    return LibraryPageWeb();
  }
}
