import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/directory_saved_entity.dart';
import '../respositories/splay_repository.dart';

class GetDirectorySavedByIdCase {
  final SplayRepository repository;

  GetDirectorySavedByIdCase({required this.repository});

  Future<Either<Failure, DirectorySavedEntity>> execute({required String id}) =>
      repository.getDirectorySavedById(id: id);
}
