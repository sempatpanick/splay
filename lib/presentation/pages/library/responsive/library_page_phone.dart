import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/state_enum.dart';
import '../../../../common/theme.dart';
import '../../../controllers/library_controller.dart';

class LibraryPagePhone extends StatelessWidget {
  const LibraryPagePhone({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GetX<LibraryController>(
      builder: (controller) => SingleChildScrollView(
        child: SafeArea(
          child: Column(
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.myLibrary.length,
                  itemBuilder: (context, index) {
                    final item = controller.myLibrary[index];

                    return ListTile(
                      dense: true,
                      minVerticalPadding: 0,
                      minLeadingWidth: 0,
                      onTap: () => controller.mainController.playMusic(item.file, item.metaData),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: item.metaData.albumArt != null
                            ? Image.memory(
                                item.metaData.albumArt!,
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                'https://cdn.pixabay.com/photo/2019/08/11/18/27/icon-4399630_1280.png',
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                      ),
                      title: Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        item.metaData.albumArtistName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorGrey3,
                        ),
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
