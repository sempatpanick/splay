import 'dart:async';
import 'dart:io';

import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:splay/common/snackbar.dart';

import '../../common/state_enum.dart';
import '../../domain/usecases/get_files_from_directory_case.dart';
import '../../domain/usecases/get_meta_data_list_case.dart';
import '../../injection.dart';
import 'main_controller.dart';

class LibraryController extends GetxController {
  final GetFilesFromDirectoryCase getFilesFromDirectoryCase = locator();
  final GetMetaDataListCase getMetaDataListCase = locator();

  final MainController mainController = Get.find<MainController>();

  Rx<RequestState> stateLibrary = RequestState.empty.obs;
  Rx<RequestState> stateMetaDataLibrary = RequestState.empty.obs;

  RxList<FileSystemEntity> myLibrary = <FileSystemEntity>[].obs;
  RxList<Metadata> metadataMyLibrary = <Metadata>[].obs;

  Future<void> initialize() async {
    await getFilesFromDirectory();
    await getMetaData();
  }

  Future<void> getFilesFromDirectory() async {
    changeStateLibrary(RequestState.loading);

    String path = "E:/Dadang/Lagu/Laguku";

    final result = await getFilesFromDirectoryCase.execute(path: path);

    result.fold((l) {
      failedSnackBar("", l.message);
      changeStateLibrary(RequestState.error);
    }, (r) {
      myLibrary.assignAll(r);
      changeStateLibrary(RequestState.loaded);
    });
  }

  Future<void> getMetaData() async {
    changeStateMetaDataLibrary(RequestState.loading);
    final paths = myLibrary.map((item) => item.path).toList();

    if (paths.isEmpty) {
      changeStateMetaDataLibrary(RequestState.error);
      return;
    }

    final result = await getMetaDataListCase.execute(paths: paths);

    result.fold((l) {
      failedSnackBar("", l.message);
      changeStateMetaDataLibrary(RequestState.error);
    }, (r) {
      metadataMyLibrary.assignAll(r);
      changeStateMetaDataLibrary(RequestState.loaded);
    });
  }

  void changeStateLibrary(RequestState state) {
    stateLibrary.value = state;
    update();
  }

  void changeStateMetaDataLibrary(RequestState state) {
    stateMetaDataLibrary.value = state;
    update();
  }
}
