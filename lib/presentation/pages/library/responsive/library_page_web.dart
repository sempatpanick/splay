import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:splay/common/state_enum.dart';
import 'package:splay/presentation/controllers/library_controller.dart';

import '../../../../common/theme.dart';

class LibraryPageWeb extends StatelessWidget {
  final LibraryController controller = Get.put(LibraryController());

  LibraryPageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search for artist, songs & albums..',
                  labelStyle: theme.textTheme.subtitle1?.copyWith(color: colorGrey3),
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
                style: theme.textTheme.headline4?.copyWith(
                  color: colorBlack,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              if (controller.mainController.stateLibrary.value == RequestState.loading)
                Center(
                  child: CircularProgressIndicator(
                    color: theme.primaryColor,
                    backgroundColor: colorGrey2,
                  ),
                ),
              if (controller.mainController.stateLibrary.value == RequestState.loaded)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 18.0,
                    crossAxisSpacing: 50.0,
                    mainAxisExtent: 220,
                  ),
                  itemCount: controller.mainController.myLibrary.length,
                  itemBuilder: (context, index) {
                    final library = controller.mainController.myLibrary[index];
                    final metaData = controller.mainController.metadataMyLibrary[index];

                    return InkWell(
                      onTap: () => controller.mainController.playMusic(library, metaData),
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
                                  child: metaData.albumArt != null
                                      ? Image.memory(metaData.albumArt!)
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
                            (metaData.trackName ?? '').isNotEmpty
                                ? metaData.trackName ?? ''
                                : p.basenameWithoutExtension(library.path),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.subtitle1?.copyWith(
                              color: colorBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            metaData.albumArtistName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.subtitle1?.copyWith(
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
    );
  }
}
