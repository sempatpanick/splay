import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../common/snackbar.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/directory_saved_entity.dart';
import '../../domain/usecases/get_directory_saved_case.dart';
import '../../domain/usecases/remove_directory_saved_case.dart';
import '../../domain/usecases/save_directory_case.dart';
import '../../injection.dart';

class SettingsController extends GetxController {
  final GetDirectorySavedCase getDirectorySavedCase = locator();
  final SaveDirectoryCase saveDirectoryCase = locator();
  final RemoveDirectorySavedCase removeDirectorySavedCase = locator();

  Rx<RequestState> stateGetDirectorySaved = RequestState.loading.obs;
  Rx<RequestState> stateSaveDirectory = RequestState.loading.obs;
  Rx<RequestState> stateRemoveDirectorySaved = RequestState.loading.obs;

  RxList<DirectorySavedEntity> directories = <DirectorySavedEntity>[].obs;

  Future<void> getDirectorySaved() async {
    changeStateGetDirectorySaved(RequestState.loading);

    final result = await getDirectorySavedCase.execute();

    result.fold((l) {
      changeStateGetDirectorySaved(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      directories.assignAll(r);
      if (directories.isEmpty) {
        changeStateGetDirectorySaved(RequestState.empty);
        return;
      }
      changeStateGetDirectorySaved(RequestState.loaded);
    });
  }

  Future<void> addNewDirectory() async {
    changeStateSaveDirectory(RequestState.loading);

    String? path;

    if (Platform.isWindows) {
      final directory = DirectoryPicker();
      path = directory.getDirectory()?.path;
    } else {
      path = await FilePicker.platform.getDirectoryPath();
    }

    if (path == null) return;

    final data = DirectorySavedEntity(
      id: const Uuid().v4(),
      path: path,
    );
    final result = await saveDirectoryCase.execute(directory: data);

    result.fold((l) {
      changeStateSaveDirectory(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      successSnackBar("", r);
      getDirectorySaved();
      changeStateSaveDirectory(RequestState.loaded);
    });
  }

  Future<void> removeDirectorySaved({required DirectorySavedEntity directory}) async {
    changeStateSaveDirectory(RequestState.loading);

    final result = await removeDirectorySavedCase.execute(directory: directory);

    result.fold((l) {
      changeStateSaveDirectory(RequestState.error);
      failedSnackBar("", l.message);
    }, (r) {
      successSnackBar("", r);
      getDirectorySaved();
      changeStateSaveDirectory(RequestState.loaded);
    });
  }

  void changeStateGetDirectorySaved(RequestState state) {
    stateGetDirectorySaved.value = state;
    stateGetDirectorySaved.refresh();
  }

  void changeStateSaveDirectory(RequestState state) {
    stateSaveDirectory.value = state;
    stateSaveDirectory.refresh();
  }

  void changeStateRemoveDirectorySaved(RequestState state) {
    stateRemoveDirectorySaved.value = state;
    stateRemoveDirectorySaved.refresh();
  }
}
