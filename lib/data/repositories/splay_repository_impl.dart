import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import '../../common/failure.dart';
import '../../domain/respositories/splay_repository.dart';
import '../datasources/splay_file_data_source.dart';

class SplayRepositoryImpl implements SplayRepository {
  final SplayFileDataSource fileDataSource;

  SplayRepositoryImpl({
    required this.fileDataSource,
  });

  @override
  Future<Either<Failure, List<FileSystemEntity>>> getFilesFromDirectory({
    required String path,
  }) async {
    try {
      final result = await fileDataSource.getFilesFromDirectory(path: path);

      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Metadata>>> getMetaDataList({required List<String> paths}) async {
    try {
      final result = await fileDataSource.getMetaDataList(paths: paths);

      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
