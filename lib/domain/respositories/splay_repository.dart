import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import '../../common/failure.dart';
import '../entities/directory_saved_entity.dart';

abstract class SplayRepository {
  Future<List<FileSystemEntity>> getFilesFromDirectory({required String path});
  Future<List<Metadata>> getMetaDataList({required List<String> paths});
  Future<Either<Failure, String>> insertDirectorySaved({
    required DirectorySavedEntity directory,
  });
  Future<Either<Failure, String>> removeDirectorySaved({
    required DirectorySavedEntity directory,
  });
  Future<bool> isAddedToSavedDirectory({required String id});
  Future<Either<Failure, DirectorySavedEntity>> getDirectorySavedById({
    required String id,
  });
  Future<Either<Failure, List<DirectorySavedEntity>>> getDirectorySaved();
}
