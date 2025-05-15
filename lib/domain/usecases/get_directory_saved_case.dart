import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/directory_saved_entity.dart';
import '../respositories/splay_repository.dart';

class GetDirectorySavedCase {
  final SplayRepository repository;

  GetDirectorySavedCase({required this.repository});

  Future<Either<Failure, List<DirectorySavedEntity>>> execute() =>
      repository.getDirectorySaved();
}
