import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import '../../common/failure.dart';

abstract class SplayRepository {
  Future<Either<Failure, List<FileSystemEntity>>> getFilesFromDirectory({required String path});
  Future<Either<Failure, List<Metadata>>> getMetaDataList({required List<String> paths});
}
