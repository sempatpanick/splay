import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../common/snackbar.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/directory_saved_entity.dart';
import '../../domain/entities/file_meta_data_entity.dart';
import '../../domain/usecases/get_directory_saved_case.dart';
import '../../domain/usecases/get_files_from_directory_case.dart';
import '../../domain/usecases/get_meta_data_list_case.dart';
import '../../domain/usecases/save_directory_case.dart';
import '../../injection.dart';
import 'main_controller.dart';

class LibraryController extends GetxController {
  final GetFilesFromDirectoryCase getFilesFromDirectoryCase = locator();
  final GetMetaDataListCase getMetaDataListCase = locator();
  final SaveDirectoryCase saveDirectoryCase = locator();
  final GetDirectorySavedCase getDirectorySavedCase = locator();

  final MainController mainController = Get.find<MainController>();

  Rx<RequestState> stateLibrary = RequestState.empty.obs;

  RxList<FileMetaDataEntity> myLibrary = <FileMetaDataEntity>[].obs;

  Future<void> initialize() async {
    await getDirectorySaved();
  }

  Future<void> getDirectorySaved() async {
    changeStateLibrary(RequestState.loading);

    myLibrary.clear();

    final result = await getDirectorySavedCase.execute();

    result.fold(
      (l) {
        failedSnackBar("", l.message);
        changeStateLibrary(RequestState.error);
      },
      (r) async {
        final List<FileMetaDataEntity> dataList = [];

        await Future.forEach(r, (item) async {
          final files = await getFilesFromDirectory(path: item.path);
          final metaDataList = await getMetaData(
            paths: files.map((item) => item.path).toList(),
          );
          files.asMap().forEach((index, value) {
            dataList.add(
              FileMetaDataEntity(
                title:
                    (metaDataList[index].trackName ?? '').isNotEmpty
                        ? metaDataList[index].trackName ?? ''
                        : basenameWithoutExtension(value.path),
                file: value,
                metaData: metaDataList[index],
              ),
            );
          });
        });

        dataList.sort((a, b) => a.title.compareTo(b.title));
        myLibrary.assignAll(dataList);
        changeStateLibrary(RequestState.loaded);
      },
    );
  }

  Future<void> addNewDirectory() async {
    String? path;

    if (Platform.isWindows) {
      final directory = DirectoryPicker();
      path = directory.getDirectory()?.path;
    } else {
      path = await FilePicker.platform.getDirectoryPath();
    }

    if (path == null) return;

    final data = DirectorySavedEntity(id: const Uuid().v4(), path: path);
    final result = await saveDirectoryCase.execute(directory: data);

    result.fold((l) => failedSnackBar("", l.message), (r) {
      initialize();
      successSnackBar("", r);
    });
  }

  Future<List<FileSystemEntity>> getFilesFromDirectory({
    required String path,
  }) async {
    final result = await getFilesFromDirectoryCase.execute(path: path);

    return result;
  }

  Future<List<Metadata>> getMetaData({required List<String> paths}) async {
    if (paths.isEmpty) {
      return [];
    }

    final result = await getMetaDataListCase.execute(paths: paths);

    return result;
  }

  void changeStateLibrary(RequestState state) {
    stateLibrary.value = state;
    update();
  }
}
