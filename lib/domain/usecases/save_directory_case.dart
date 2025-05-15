import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/directory_saved_entity.dart';
import '../respositories/splay_repository.dart';

class SaveDirectoryCase {
  final SplayRepository repository;

  SaveDirectoryCase({required this.repository});

  Future<Either<Failure, String>> execute({
    required DirectorySavedEntity directory,
  }) => repository.insertDirectorySaved(directory: directory);
}
