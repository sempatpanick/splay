import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/entities/directory_saved_entity.dart';
import '../../domain/respositories/splay_repository.dart';
import '../datasources/splay_file_data_source.dart';
import '../datasources/splay_local_data_source.dart';

class SplayRepositoryImpl implements SplayRepository {
  final SplayFileDataSource fileDataSource;
  final SplayLocalDataSource localDataSource;

  SplayRepositoryImpl({
    required this.fileDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<FileSystemEntity>> getFilesFromDirectory({
    required String path,
  }) async {
    try {
      final result = await fileDataSource.getFilesFromDirectory(path: path);

      return result;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Metadata>> getMetaDataList({required List<String> paths}) async {
    try {
      final result = await fileDataSource.getMetaDataList(paths: paths);

      return result;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Either<Failure, String>> insertDirectorySaved({
    required DirectorySavedEntity directory,
  }) async {
    try {
      final result = await localDataSource.insertDirectorySaved(directory: directory.toModel());
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(ResponseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> removeDirectorySaved({
    required DirectorySavedEntity directory,
  }) async {
    try {
      final result = await localDataSource.removeDirectorySaved(directory: directory.toModel());
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(ResponseFailure(e.toString()));
    }
  }

  @override
  Future<bool> isAddedToSavedDirectory({required String id}) async {
    final result = await localDataSource.getDirectorySavedById(id: id);
    return result != null;
  }

  @override
  Future<Either<Failure, DirectorySavedEntity>> getDirectorySavedById({required String id}) async {
    try {
      final result = await localDataSource.getDirectorySavedById(id: id);

      if (result == null) {
        return const Left(ResponseFailure("No directory found"));
      }

      return Right(result.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(ResponseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DirectorySavedEntity>>> getDirectorySaved() async {
    try {
      final result = await localDataSource.getDirectorySaved();
      return Right(result.map((item) => item.toEntity()).toList());
    } on DatabaseException catch (e) {
      print(e.message);
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      print(e);
      return Left(ResponseFailure(e.toString()));
    }
  }
}
