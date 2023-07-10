import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../respositories/splay_repository.dart';

class GetFilesFromDirectoryCase {
  final SplayRepository repository;

  GetFilesFromDirectoryCase({required this.repository});

  Future<Either<Failure, List<FileSystemEntity>>> execute({required String path}) =>
      repository.getFilesFromDirectory(
        path: path,
      );
}
