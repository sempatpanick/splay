import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splay/common/state_enum.dart';
import 'package:splay/presentation/controllers/library_controller.dart';

import '../../../../common/theme.dart';

class LibraryPageWeb extends StatelessWidget {
  const LibraryPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GetX<LibraryController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Search for artist, songs & albums..',
                    labelStyle: theme.textTheme.titleMedium?.copyWith(color: colorGrey3),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: colorGrey3,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Discover",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: colorBlack,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                if (controller.stateLibrary.value == RequestState.loading)
                  Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                      backgroundColor: colorGrey2,
                    ),
                  ),
                if (controller.stateLibrary.value == RequestState.loaded)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 18.0,
                      crossAxisSpacing: 50.0,
                      mainAxisExtent: 222,
                    ),
                    itemCount: controller.myLibrary.length,
                    itemBuilder: (context, index) {
                      final item = controller.myLibrary[index];

                      return InkWell(
                        onTap: () => controller.mainController.playMusic(item.file, item.metaData),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: colorGrey2.withOpacity(.5),
                                        offset: const Offset(10, 10),
                                        blurRadius: 15,
                                        spreadRadius: -1),
                                    BoxShadow(
                                        color: colorGrey2.withOpacity(.5),
                                        offset: const Offset(-10, 0),
                                        blurRadius: 15,
                                        spreadRadius: -1),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: SizedBox.fromSize(
                                    size: const Size(150, 150),
                                    child: item.metaData.albumArt != null
                                        ? Image.memory(item.metaData.albumArt!)
                                        : Image.network(
                                            'https://cdn.pixabay.com/photo/2019/08/11/18/27/icon-4399630_1280.png',
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              item.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colorBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              item.metaData.albumArtistName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colorGrey3,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              backgroundColor: colorWhite,
              onPressed: controller.initialize,
              tooltip: "Refresh",
              child: Icon(
                Icons.refresh,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(
              width: 24.0,
            ),
            FloatingActionButton(
              backgroundColor: colorWhite,
              onPressed: controller.addNewDirectory,
              tooltip: "Add Folder",
              child: Icon(
                CupertinoIcons.folder_badge_plus,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
