import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../common/exception.dart';
import '../models/directory_saved_model.dart';
import 'db/database_helper.dart';
import 'db/database_helper_desktop.dart';

abstract class SplayLocalDataSource {
  Future<String> insertDirectorySaved({required DirectorySavedModel directory});
  Future<String> removeDirectorySaved({required DirectorySavedModel directory});
  Future<DirectorySavedModel?> getDirectorySavedById({required String id});
  Future<List<DirectorySavedModel>> getDirectorySaved();
}

class SplayLocalDataSourceImpl implements SplayLocalDataSource {
  final DatabaseHelper databaseHelper;
  final DatabaseHelperDesktop databaseHelperDesktop;

  SplayLocalDataSourceImpl({
    required this.databaseHelper,
    required this.databaseHelperDesktop,
  });

  @override
  Future<String> insertDirectorySaved({
    required DirectorySavedModel directory,
  }) async {
    try {
      if (Platform.isWindows || Platform.isLinux || kIsWeb) {
        await databaseHelperDesktop.insertDirectorySaved(directory: directory);
      } else {
        await databaseHelper.insertDirectorySaved(directory: directory);
      }
      return 'Directory has been added';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeDirectorySaved({
    required DirectorySavedModel directory,
  }) async {
    try {
      if (Platform.isWindows || Platform.isLinux || kIsWeb) {
        await databaseHelperDesktop.removeDirectorySaved(directory: directory);
      } else {
        await databaseHelper.removeDirectorySaved(directory: directory);
      }
      return 'Directory has been removed';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<DirectorySavedModel?> getDirectorySavedById({
    required String id,
  }) async {
    try {
      Map<String, dynamic>? result;
      if (Platform.isWindows || Platform.isLinux || kIsWeb) {
        result = await databaseHelperDesktop.getDirectorySavedById(id: id);
      } else {
        result = await databaseHelper.getDirectorySavedById(id: id);
      }
      if (result != null) {
        return DirectorySavedModel.fromJson(result);
      } else {
        return null;
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<DirectorySavedModel>> getDirectorySaved() async {
    List<Map<String, dynamic>> result = [];
    try {
      if (Platform.isWindows || Platform.isLinux || kIsWeb) {
        result = await databaseHelperDesktop.getDirectorySaved();
      } else {
        result = await databaseHelper.getDirectorySaved();
      }
      return result.map((item) => DirectorySavedModel.fromJson(item)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
