import 'dart:io';

import '../respositories/splay_repository.dart';

class GetFilesFromDirectoryCase {
  final SplayRepository repository;

  GetFilesFromDirectoryCase({required this.repository});

  Future<List<FileSystemEntity>> execute({required String path}) =>
      repository.getFilesFromDirectory(path: path);
}
